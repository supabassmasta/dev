/*
 *  Copyright (C) 2003 Jan C. Depner, Jack O'Quin, Steve Harris
 *
 *  This program is free software; you can redistribute it and/or modify
 *  it under the terms of the GNU General Public License as published by
 *  the Free Software Foundation; either version 2 of the License, or
 *  (at your option) any later version.
 *
 *  This program is distributed in the hope that it will be useful,
 *  but WITHOUT ANY WARRANTY; without even the implied warranty of
 *  MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
 *  GNU General Public License for more details.
 *
 *  $Id: process.c,v 1.65 2004/10/28 08:20:33 theno23 Exp $
 */

#include <math.h>
#include <string.h>
#include <stdlib.h>
#include <jack/jack.h>
#include <fftw3.h>
#include <assert.h>

#include "config.h"
#include "state.h"
#include "process.h"
#include "compressor.h"
#include "limiter.h"
#include "geq.h"
#include "scenes.h"
#include "intrim.h"
#include "io.h"
#include "db.h"
#include "denormal-kill.h"

#define BIQUAD_TYPE double
#include "biquad.h"

#define BUF_MASK   (BINS-1)		/* BINS is a power of two */

#define LERP(f,a,b) ((a) + (f) * ((b) - (a)))

#define IS_DENORMAL(fv) (((*(unsigned int*)&(fv))&0x7f800000)!=0)

typedef FFTW_TYPE fft_data;

static int xo_band_action[XO_NBANDS] = {ACTIVE, ACTIVE, ACTIVE};
static int xo_band_action_pending[XO_NBANDS] = {ACTIVE, ACTIVE, ACTIVE};

/* These values need to be controlled by the UI, somehow */
float xover_fa = 207.0f;
float xover_fb = 2048.0f;
comp_settings compressors[XO_NBANDS];
lim_settings limiter;
float eq_coefs[BINS]; /* Linear gain of each FFT bin */
float lim_peak[2];

static int iir_xover = 0;

float in_peak[NCHANNELS], out_peak[NCHANNELS];

static float band_f[BANDS];
static float gain_fix[BANDS];
static float bin_peak[BINS];
static int bands[BINS];
static float in_buf[NCHANNELS][BINS];
static float mid_buf[NCHANNELS][BINS];
static float out_buf[NCHANNELS][XO_NBANDS][BINS];
static biquad xo_filt[NCHANNELS][(XO_NBANDS-1) * 2];
static float window[BINS];
static fft_data *real;
static fft_data *comp;
static fft_data *comp_tmp;
static float *out_tmp[NCHANNELS][XO_NBANDS];
static float sw_m_gain[XO_NBANDS];
static float sw_s_gain[XO_NBANDS];
static float sb_l_gain[XO_NBANDS];
static float sb_r_gain[XO_NBANDS];
static float limiter_gain = 1.0f;

static float ws_boost_wet = 0.0f;
static float ws_boost_a = 1.0f;

static unsigned int latcorbuf_pos;
static unsigned int latcorbuf_len;
static float *latcorbuf[NCHANNELS];
static float *latcorbuf_postcomp[NCHANNELS];

static int spectrum_mode = SPEC_POST_EQ;

volatile int global_bypass = 0;		/* updated from GUI thread */
static int eq_bypass_pending = FALSE;
static int eq_bypass = FALSE;
static int limiter_bypass_pending = FALSE;
static int limiter_bypass = FALSE;

/* Data for plugins */
plugin *comp_plugin, *lim_plugin;

/* FFTW data */
fftwf_plan plan_rc = NULL, plan_cr = NULL;

float sample_rate = 0.0f;

/* Desired block size for calling process_signal(). */
const jack_nframes_t dsp_block_size = BINS / OVER_SAMP;

#ifdef FILTER_TUNING
float ft_bias_a_val = 1.0f;
float ft_bias_a_hp_val = 1.0f;
float ft_bias_b_val = 1.0f;
float ft_bias_b_hp_val = 1.0f;
float ft_rez_lp_a_val = 1.2;
float ft_rez_hp_a_val = 1.2;
float ft_rez_lp_b_val = 1.2;
float ft_rez_hp_b_val = 1.2;
#endif

void run_eq(unsigned int port, unsigned int in_pos);
void run_eq_iir(unsigned int port, unsigned int in_pos);
void run_width(int xo_band, float *left, float *right, int nframes);

void process_init(float fs)
{
    float centre = 25.0f;
    unsigned int i, j, band;

    sample_rate = fs;

    for (i = 0; i < BANDS; i++) {
	band_f[i] = centre;
	//printf("band %d = %fHz\n", i, centre);
	centre *= 1.25992105f;		/* up a third of an octave */
	gain_fix[i] = 0.0f;
    }

    band = 0;
    for (i = 0; i < BINS / 2; i++) {
	const float binfreq =
	    sample_rate * 0.5f * (i + 0.5f) / (float) BINS;

	while (binfreq > (band_f[band] + band_f[band + 1]) * 0.5f) {
	    band++;
	    if (band >= BANDS - 1) {
		band = BANDS - 1;
		break;
	    }
	}
	bands[i] = band;
	gain_fix[band]++;
	//printf("bin %d (%f) -> band %d (%f) #%d\n", i, binfreq, band, band_f[band], (int)gain_fix[band]);
    }

    for (i = 0; i < BANDS; i++) {
	if (gain_fix[i] != 0.0f) {
	    gain_fix[i] = 1.0f / gain_fix[i];
	} else {
	    /* There are no bins for this band, reassign a nearby one */
	    for (j = 0; j < BINS / 2; j++) {
		if (bands[j] > i) {
		    gain_fix[bands[j]]--;
		    bands[j] = i;
		    gain_fix[i] = 1.0f;
		    break;
		}
	    }
	}
    }

    /* Allocate space for FFT data */
    real = fftwf_malloc(sizeof(fft_data) * BINS);
    comp = fftwf_malloc(sizeof(fft_data) * BINS);
    comp_tmp = fftwf_malloc(sizeof(fft_data) * BINS);

    plan_rc = fftwf_plan_r2r_1d(BINS, real, comp, FFTW_R2HC, FFTW_MEASURE);
    plan_cr = fftwf_plan_r2r_1d(BINS, comp_tmp, real, FFTW_HC2R, FFTW_MEASURE);

    /* Calculate root raised cosine window */
    for (i = 0; i < BINS; i++) {
       window[i] = -0.5f * cosf(2.0f * M_PI * (float) i /
                                (float) BINS) + 0.5f;
/* root rasied cosine window - aparently sounds worse ...
	window[i] = sqrtf(0.5f + -0.5 * cosf(2.0f * M_PI * (float) i /
			  (float) BINS));
*/
    }

    plugin_init();
    comp_plugin = plugin_load("sc4_1882.so");
    lim_plugin = plugin_load("fast_lookahead_limiter_1913.so");
    if (comp_plugin == NULL || lim_plugin == NULL)  {
           fprintf(stderr, "Required plugin missing.\n");
           exit(1);
    }

    /* This compressor is specifically stereo, so there are always two
     * channels. */
    for (band = 0; band < XO_NBANDS; band++) {
	out_tmp[CHANNEL_L][band] = calloc(dsp_block_size, sizeof(float));
	out_tmp[CHANNEL_R][band] = calloc(dsp_block_size, sizeof(float));
	compressors[band].handle = plugin_instantiate(comp_plugin, fs);
	comp_connect(comp_plugin, &compressors[band],
		     out_tmp[CHANNEL_L][band], out_tmp[CHANNEL_R][band]);
    }

    limiter.handle = plugin_instantiate(lim_plugin, fs);
    lim_connect(lim_plugin, &limiter, NULL, NULL);

    /* Allocate at least 1 second of latency correction buffer */
    for (latcorbuf_len = 256; latcorbuf_len < fs * 1.0f; latcorbuf_len *= 2);
    latcorbuf_pos = 0;
    for (i=0; i < NCHANNELS; i++) {
	latcorbuf[i] = calloc(latcorbuf_len, sizeof(float));
	latcorbuf_postcomp[i] = calloc(latcorbuf_len, sizeof(float));
    }

    /* Clear the corssover filters state */
    memset(xo_filt, 0, sizeof(xo_filt));
}

void run_eq(unsigned int port, unsigned int in_ptr)
{
    const float fix = 2.5f / ((float) BINS * (float) OVER_SAMP);
    float peak;
    unsigned int i, j;
    int targ_bin;
    float *peak_data;

    for (i = 0; i < BINS; i++) {
	real[i] = window[i] * in_buf[port][(in_ptr + i) & BUF_MASK];
    }

    fftwf_execute(plan_rc);

    /* run the EQ + spectrum an. + xover process */

    if (spectrum_mode == SPEC_PRE_EQ) {
	peak_data = comp;
    } else {
	peak_data = comp_tmp;
    }

    memset(comp_tmp, 0, BINS * sizeof(fft_data));
    targ_bin = xover_fa / sample_rate * ((float)BINS + 0.5f);

    comp_tmp[0] = comp[0] * eq_coefs[0];
    if (comp_tmp[0] > bin_peak[0]) bin_peak[0] = comp_tmp[0];
    
    for (i = 1; i < targ_bin && i < BINS / 2 - 1; i++) {
	const float eq_gain = xo_band_action[XO_LOW] == MUTE ? 0.0f :
				(eq_bypass ? 1.0f : eq_coefs[i]);

	comp_tmp[i] = comp[i] * eq_gain;
	comp_tmp[BINS - i] = comp[BINS - i] * eq_gain;

	peak = sqrtf(peak_data[i] * peak_data[i] + peak_data[BINS - i] *
		peak_data[BINS - i]);
	if (peak > bin_peak[i]) {
	    bin_peak[i] = peak;
	}
    }
    fftwf_execute(plan_cr);
    for (j = 0; j < BINS; j++) {
	out_buf[port][XO_LOW][(in_ptr + j) & BUF_MASK] += real[j] * fix *
	    window[j];
    }

    memset(comp_tmp, 0, BINS * sizeof(fft_data));
    targ_bin = xover_fb / sample_rate * ((float)BINS + 0.5f);


    /*  Note that i falls through from the above loop.  */

    for (; i < targ_bin && i < BINS / 2 - 1; i++) {
	const float eq_gain = xo_band_action[XO_MID] == MUTE ? 0.0f :
				(eq_bypass ? 1.0f : eq_coefs[i]);

	comp_tmp[i] = comp[i] * eq_gain;
	comp_tmp[BINS - i] = comp[BINS - i] * eq_gain;
	peak = sqrtf(peak_data[i] * peak_data[i] + peak_data[BINS - i] *
		peak_data[BINS - i]);
	if (peak > bin_peak[i]) {
	    bin_peak[i] = peak;
	}
    }
    fftwf_execute(plan_cr);
    for (j = 0; j < BINS; j++) {
	out_buf[port][XO_MID][(in_ptr + j) & BUF_MASK] += real[j] * fix *
	    window[j];
    }

    memset(comp_tmp, 0, BINS * sizeof(fft_data));


    /*  Again, note that i falls through from the above loop.  */

    for (; i < BINS / 2 - 1; i++) {
	const float eq_gain = xo_band_action[XO_HIGH] == MUTE ? 0.0f :
				(eq_bypass ? 1.0f : eq_coefs[i]);

	comp_tmp[i] = comp[i] * eq_gain;
	comp_tmp[BINS - i] = comp[BINS - i] * eq_gain;
	peak = sqrtf(peak_data[i] * peak_data[i] + peak_data[BINS - i] *
		peak_data[BINS - i]);
	if (peak > bin_peak[i]) {
	    bin_peak[i] = peak;
	}
    }
    fftwf_execute(plan_cr);
    for (j = 0; j < BINS; j++) {
	out_buf[port][XO_HIGH][(in_ptr + j) & BUF_MASK] += real[j] * fix *
	    window[j];
    }
}

/* this is like run_eq except that it only uses a FFT to do the EQ, 
   the crossover is handled by IIR filters */

void run_eq_iir(unsigned int port, unsigned int in_ptr)
{
    const float fix = 2.5f / ((float) BINS * (float) OVER_SAMP);
    float peak;
    unsigned int i, j;
    int targ_bin;
    float *peak_data;

    for (i = 0; i < BINS; i++) {
	real[i] = window[i] * in_buf[port][(in_ptr + i) & BUF_MASK];
    }

    fftwf_execute(plan_rc);

    /* run the EQ + spectrum an. + xover process */

    if (spectrum_mode == SPEC_PRE_EQ) {
	peak_data = comp;
    } else {
	peak_data = comp_tmp;
    }

    memset(comp_tmp, 0, BINS * sizeof(fft_data));
    targ_bin = xover_fa / sample_rate * ((float)BINS + 0.5f);

    comp_tmp[0] = comp[0] * eq_coefs[0];
    if (comp_tmp[0] > bin_peak[0]) bin_peak[0] = comp_tmp[0];
    
    for (i = 1; i < BINS / 2 - 1; i++) {
	const float eq_gain = xo_band_action[XO_LOW] == MUTE ? 0.0f :
				(eq_bypass ? 1.0f : eq_coefs[i]);

	comp_tmp[i] = comp[i] * eq_gain;
	comp_tmp[BINS - i] = comp[BINS - i] * eq_gain;

	peak = sqrtf(peak_data[i] * peak_data[i] + peak_data[BINS - i] *
		peak_data[BINS - i]);
	if (peak > bin_peak[i]) {
	    bin_peak[i] = peak;
	}
    }
    fftwf_execute(plan_cr);
    for (j = 0; j < BINS; j++) {
	mid_buf[port][(in_ptr + j) & BUF_MASK] += real[j] * fix * window[j];
    }
}

#define EPSILON 0.0000001f		/* small positive number */
float bin_peak_read_and_clear(int bin)
{
    float ret = bin_peak[bin];
    const float fix = 2.0f / ((float) BINS * (float) OVER_SAMP);

    bin_peak[bin] = EPSILON;		/* don't take log(0.0) */

    return ret * fix;
}

int process_signal(jack_nframes_t nframes,
		   int nchannels,
		   jack_default_audio_sample_t *in[],
		   jack_default_audio_sample_t *out[])
{
    unsigned int pos, port, band;
    const unsigned int latency = BINS - dsp_block_size;
    static unsigned int in_ptr = 0;
    static unsigned int n_calc_pt = BINS - (BINS / OVER_SAMP);

    /* The limiters i/o ports potentially change with every call */
    plugin_connect_port(lim_plugin, limiter.handle, LIM_IN_1, out[CHANNEL_L]);
    plugin_connect_port(lim_plugin, limiter.handle, LIM_IN_2, out[CHANNEL_R]);
    plugin_connect_port(lim_plugin, limiter.handle, LIM_OUT_1, out[CHANNEL_L]);
    plugin_connect_port(lim_plugin, limiter.handle, LIM_OUT_2, out[CHANNEL_R]);

    /* Crossfade parameter values from current to target */
    s_crossfade(nframes);

    if (iir_xover) {
	for (port = 0; port < nchannels; port++) {
#ifdef FILTER_TUNING
	    lp_set_params(&xo_filt[port][0], xover_fa * ft_bias_a_val,
			   ft_rez_lp_a_val, sample_rate);
	    hp_set_params(&xo_filt[port][1], xover_fa * ft_bias_a_hp_val,
			   ft_rez_lp_a_val, sample_rate);
	    lp_set_params(&xo_filt[port][2], xover_fb * ft_bias_b_val,
			   ft_rez_lp_b_val, sample_rate);
	    hp_set_params(&xo_filt[port][3], xover_fb * ft_bias_b_hp_val,
			   ft_rez_lp_b_val, sample_rate);
#else
	    const double bw_a = 1.0/((60.0*(xover_fa/sample_rate))+0.5);
	    const double bw_b = 1.0/((60.0*(xover_fb/sample_rate))+0.5);

	    lp_set_params(&xo_filt[port][0], xover_fa, bw_a, sample_rate);
	    hp_set_params(&xo_filt[port][1], xover_fa, bw_a, sample_rate);
	    lp_set_params(&xo_filt[port][2], xover_fb, bw_b, sample_rate);
	    hp_set_params(&xo_filt[port][3], xover_fb, bw_b, sample_rate);
#endif
	}
    }

    for (pos = 0; pos < nframes; pos++) {
	const unsigned int op = (in_ptr - latency) & BUF_MASK;
	float amp;

	for (port = 0; port < nchannels; port++) {
	    in_buf[port][in_ptr] = in[port][pos] * in_gain[port];
	    denormal_kill(&in_buf[port][in_ptr]);
	    if (in_buf[port][in_ptr] > 100.0f) {
		in_buf[port][in_ptr] = 100.0f;
	    } else if (in_buf[port][in_ptr] < -100.0f) {
		in_buf[port][in_ptr] = -100.0f;
	    }
#if 0
	    if (IS_DENORMAL(in_buf[port][in_ptr])) {
//printf("denormal");
		in_buf[port][in_ptr] = 0.0f;
	    }
	    if (!finite(in_buf[port][in_ptr])) {
printf("WARNING: wierd input: %f\n", in_buf[port][in_ptr]);
		if (isnan(in_buf[port][in_ptr])) {
		    in_buf[port][in_ptr] = 0.0f;
		} else if (in_buf[port][in_ptr] > 0.0f) {
		    in_buf[port][in_ptr] = 1.0f;
		} else {
		    in_buf[port][in_ptr] = -1.0f;
		}
	    }
#endif
	    amp = fabs(in_buf[port][in_ptr]);
	    if (amp > in_peak[port]) {
		in_peak[port] = amp;
	    }

	    if (iir_xover) {
		const float x = mid_buf[port][op];
		const float a = biquad_run(&xo_filt[port][0], x);
		const float y = biquad_run(&xo_filt[port][1], x);
		const float b = biquad_run(&xo_filt[port][2], y);
		const float c = biquad_run(&xo_filt[port][3], y);

		out_tmp[port][XO_LOW][pos] = a;
		out_tmp[port][XO_MID][pos] = b;
		out_tmp[port][XO_HIGH][pos] = c;
		mid_buf[port][op] = 0.0f;
	    } else {
		out_tmp[port][XO_LOW][pos] = out_buf[port][XO_LOW][op];
		out_buf[port][XO_LOW][op] = 0.0f;
		out_tmp[port][XO_MID][pos] = out_buf[port][XO_MID][op];
		out_buf[port][XO_MID][op] = 0.0f;
		out_tmp[port][XO_HIGH][pos] = out_buf[port][XO_HIGH][op];
		out_buf[port][XO_HIGH][op] = 0.0f;
	    }
	}

	in_ptr = (in_ptr + 1) & BUF_MASK;

	if (in_ptr == n_calc_pt) {	/* time to do the FFT? */
	    if (!global_bypass) {
		/* Just so the bypass can't kick in in the middle of
		 * precessing, might do something wierd */
		eq_bypass = eq_bypass_pending;
		limiter_bypass = limiter_bypass_pending;

		if (iir_xover) {
		    run_eq_iir(CHANNEL_L, in_ptr);
		    run_eq_iir(CHANNEL_R, in_ptr);
		} else {
		    run_eq(CHANNEL_L, in_ptr);
		    run_eq(CHANNEL_R, in_ptr);
		}
	    }
	    /* Work out when we can run it again */
	    n_calc_pt = (in_ptr + dsp_block_size) & BUF_MASK;
	}
    }

    /* Handle solo and mute for the IIR crossove case */
    if (iir_xover) {
	for (port = 0; port < nchannels; port++) {
	    for (band = XO_LOW; band < XO_NBANDS; band++) {
		if (xo_band_action[band] == MUTE) {
		    for (pos = 0; pos < nframes; pos++) {
			out_tmp[port][band][pos] = 0.0f;
		    }
		}
	    }
	}
    }

    //printf("rolled fifo's...\n");

    for (band = XO_LOW; band < XO_NBANDS; band++) {
	if (xo_band_action[band] == ACTIVE) {
	    plugin_run(comp_plugin, compressors[band].handle, nframes);
	    run_width(band, out_tmp[CHANNEL_L][band],
			out_tmp[CHANNEL_R][band], nframes);
	}
    }

    //printf("run compressors...\n");

    for (port = 0; port < nchannels; port++) {
	for (pos = 0; pos < nframes; pos++) {
	    out[port][pos] =
		out_tmp[port][XO_LOW][pos] + out_tmp[port][XO_MID][pos] +
		out_tmp[port][XO_HIGH][pos];
		/* Keep buffer of compressor outputs incase we need it for
		 * limiter bypass */
		latcorbuf_postcomp[port][(latcorbuf_pos + pos) &
		    (latcorbuf_len - 1)] = out[port][pos];
	}
    }

    //printf("done something...\n");

    for (pos = 0; pos < nframes; pos++) {
	for (port = 0; port < nchannels; port++) {
	    /* Apply input gain */
	    out[port][pos] *= limiter_gain;

	    /* Check for peaks */
	    if (out[port][pos] > lim_peak[LIM_PEAK_IN]) {
		lim_peak[LIM_PEAK_IN] = out[port][pos];
	    }
	}
    }

    for (port = 0; port < nchannels; port++) {
	const float a = ws_boost_a * 0.3;
	const float gain_corr = 1.0 / LERP(ws_boost_wet, 1.0,
				a > M_PI*0.5 ? 1.0 : sinf(1.0 * a));

	for (pos = 0; pos < nframes; pos++) {
	    const float x = out[port][pos] * out_gain;
	    out[port][pos] = LERP(ws_boost_wet, x, sinf(x * a)) * gain_corr;
	}
    }

    plugin_run(lim_plugin, limiter.handle, nframes);

    /* Keep a buffer of old input data, incase we need it for bypass */
    for (port = 0; port < nchannels; port++) {
	for (pos = 0; pos < nframes; pos++) {
	    latcorbuf[port][(latcorbuf_pos + pos) & (latcorbuf_len - 1)] =
		in[port][pos];
	}
    }

    /* If bypass is on override all the stuff done by the crossover section,
     * limiter and so on */
    if (limiter_bypass) {
	const unsigned int limiter_latency = (unsigned int)limiter.latency;

	for (port = 0; port < nchannels; port++) {
	    for (pos = 0; pos < nframes; pos++) {
		out[port][pos] = latcorbuf_postcomp[port][(latcorbuf_pos +
			pos - limiter_latency - nframes) & (latcorbuf_len - 1)];
	    }
	}
    }
    if (global_bypass) {
	const unsigned int limiter_latency = (unsigned int)limiter.latency;

	for (port = 0; port < nchannels; port++) {
	    for (pos = 0; pos < nframes; pos++) {
		out[port][pos] = latcorbuf[port][(latcorbuf_pos +
			pos - limiter_latency - nframes) & (latcorbuf_len - 1)];
	    }
	}
    }
    latcorbuf_pos += nframes;

    for (pos = 0; pos < nframes; pos++) {
	for (port = 0; port < nchannels; port++) {
	    const float oa = fabs(out[port][pos]);

	    if (oa > lim_peak[LIM_PEAK_OUT]) {
		lim_peak[LIM_PEAK_OUT] = oa;
	    }
	    if (oa > out_peak[port]) {
		out_peak[port] = oa;
	    }
	}
    }

    /* We've got the the end of the processing, so update the actions */

    for (band = 0; band < XO_NBANDS; band++) {
	xo_band_action[band] = xo_band_action_pending[band];
    }

    return 0;
}

float eval_comp(float thresh, float ratio, float knee, float in)
{
    /* Below knee */
    if (in <= thresh - knee) {
	return in;
    }

    /* In knee */
    if (in < thresh + knee) {
	const float x = -(thresh - knee - in) / knee;
	return in - knee * x * x * 0.25f * (ratio - 1.0f) / ratio;
    }

    /* Above knee */
    return in + (thresh - in) * (ratio - 1.0f) / ratio;
}

void process_set_spec_mode(int mode)
{
    spectrum_mode = mode;

    set_scene_warning_button ();
}

int process_get_spec_mode()
{
  return (spectrum_mode);
}

void process_set_stereo_width(int xo_band, float width)
{
    assert(xo_band >= 0 && xo_band < XO_NBANDS);

    /* Scale width to be pi/4 - pi/2, the sqrt(2) factor saves us some cycles
     * later */
    sw_m_gain[xo_band] = cosf((width + 1.0f) * 0.78539815f) * 0.7071067811f;
    sw_s_gain[xo_band] = sinf((width + 1.0f) * 0.78539815f) * 0.7071067811f;
}


/*  This is a holdover from when we had per band balance.  */

void process_set_stereo_balance(int xo_band, float bias)
{
    assert(xo_band >= 0 && xo_band < XO_NBANDS);

    sb_l_gain[xo_band] = db2lin(bias * -0.5f);
    sb_r_gain[xo_band] = db2lin(bias * 0.5f);
}

void run_width(int xo_band, float *left, float *right, int nframes)
{
    unsigned int pos;

    for (pos = 0; pos < nframes; pos++) {
	const float mid = (left[pos] + right[pos]) * sw_m_gain[xo_band];
	const float side = (left[pos] - right[pos]) * sw_s_gain[xo_band];

	left[pos] = (mid + side) * sb_l_gain[xo_band];
	right[pos] = (mid - side) * sb_r_gain[xo_band];
    }
}

void process_set_limiter_input_gain(float gain)
{
        limiter_gain = gain;
}

void process_set_ws_boost(float val)
{
    if (val < 1.0f) {
	ws_boost_wet = val;
	ws_boost_a = 1.0f;
    } else {
	ws_boost_wet = 1.0f;
	ws_boost_a = val;
    }
}

void process_set_xo_band_action(int band, int action)
{
    assert(action == ACTIVE || action == MUTE || action == BYPASS);

    xo_band_action_pending[band] = action;
}

void process_set_eq_bypass(int bypass)
{
    eq_bypass_pending = bypass;
}

void process_set_crossover_type(int type)
{
    iir_xover = type;
}

int process_get_crossover_type()
{
    return (iir_xover);
}

void process_set_limiter_bypass(int bypass)
{
    limiter_bypass_pending = bypass;
}

void process_set_low2mid_xover (float freq)
{
    xover_fa = freq;
}

void process_set_mid2high_xover (float freq)
{
    xover_fb = freq;
}

float process_get_low2mid_xover ()
{
    return (xover_fa);
}

float process_get_mid2high_xover ()
{
    return (xover_fb);
}

/* vi:set ts=8 sts=4 sw=4: */
