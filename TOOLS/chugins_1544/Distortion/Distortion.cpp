//-----------------------------------------------------------------------------
// Distortion — multi-algorithm distortion chugin for ChucK
//
// Algorithms (selectable via mode()):
//   0  HARD_CLIP  — hard clipping at ±threshold
//   1  SOFT_CLIP  — cubic polynomial smooth saturation (threshold, knee)
//   2  FOLDBACK   — fold-back / mirror distortion (foldThreshold)
//   3  TUBE       — asymmetric tube-style saturation (bias, warmth)
//   4  ARCTANGENT — arctangent soft saturation (drive)
//   5  AMPSIM     — multi-stage amplifier simulation (tone, presence)
//   6  OVERDRIVE  — exponential overdrive / Tube Screamer-like (drive, bias)
//   7  FUZZ       — high-gain square-wave fuzz (tone)
//   8  BITCRUSH   — bit-depth reduction / lo-fi quantization (bits)
//   9  WAVESHAPER — cubic-to-sine Chebyshev-inspired waveshaping (shape)
//  10  DIODE      — asymmetric exponential diode clipper (asymmetry)
//  11  SIGMOID    — logistic / S-curve saturation (slope)
//  12  SINEFOLD   — sine-based harmonic folding (threshold, foldFreq)
//  13  DECIMATOR  — sample-rate reduction via sample & hold (sampleHold)
//
// Common parameters (all modes):
//   gainIn  — pre-distortion drive gain  (default 1.0)
//   gain    — post-distortion output gain (default 1.0)
//
// Algorithm-specific parameters:
//   threshold     — clip ceiling (HARD_CLIP, SOFT_CLIP, SINEFOLD)        default 0.7
//   knee          — soft-knee blend 0=hard 1=smooth (SOFT_CLIP)          default 0.2
//   foldThreshold — fold point (FOLDBACK)                                default 0.5
//   bias          — DC asymmetry offset (TUBE, OVERDRIVE)                default 0.1
//   warmth        — even-harmonic blend (TUBE)                           default 0.5
//   drive         — pre-gain multiplier (ARCTANGENT, OVERDRIVE)          default 5.0
//   bits          — quantisation bit depth (BITCRUSH)                    default 8.0
//   sampleHold    — hold ratio 0=none →1=heavy (DECIMATOR)               default 0.5
//   shape         — waveshape coefficient 0=linear 2=sine (WAVESHAPER)   default 0.5
//   slope         — logistic steepness (SIGMOID)                         default 5.0
//   foldFreq      — fold frequency multiplier (SINEFOLD)                 default 1.0
//   tone          — tone LP blend 0=dark 1=bright (FUZZ, AMPSIM)         default 0.5
//   presence      — high-mid presence boost (AMPSIM)                     default 0.5
//   asymmetry     — positive/negative asymmetry (DIODE)                  default 0.3
//-----------------------------------------------------------------------------

#include "chugin.h"
#include <cmath>
#include <algorithm>

#ifndef M_PI
#define M_PI 3.14159265358979323846
#endif


//-----------------------------------------------------------------------------
// forward declarations
//-----------------------------------------------------------------------------
CK_DLL_CTOR( dist_ctor );
CK_DLL_DTOR( dist_dtor );
CK_DLL_TICK( dist_tick );

// mode selector
CK_DLL_MFUN( dist_setMode );
CK_DLL_MFUN( dist_getMode );

// common parameters
CK_DLL_MFUN( dist_setGainIn );
CK_DLL_MFUN( dist_getGainIn );
CK_DLL_MFUN( dist_setGain );
CK_DLL_MFUN( dist_getGain );

// threshold — HARD_CLIP, SOFT_CLIP, SINEFOLD
CK_DLL_MFUN( dist_setThreshold );
CK_DLL_MFUN( dist_getThreshold );

// knee — SOFT_CLIP
CK_DLL_MFUN( dist_setKnee );
CK_DLL_MFUN( dist_getKnee );

// foldThreshold — FOLDBACK
CK_DLL_MFUN( dist_setFoldThreshold );
CK_DLL_MFUN( dist_getFoldThreshold );

// bias — TUBE, OVERDRIVE
CK_DLL_MFUN( dist_setBias );
CK_DLL_MFUN( dist_getBias );

// warmth — TUBE
CK_DLL_MFUN( dist_setWarmth );
CK_DLL_MFUN( dist_getWarmth );

// drive — ARCTANGENT, OVERDRIVE
CK_DLL_MFUN( dist_setDrive );
CK_DLL_MFUN( dist_getDrive );

// bits — BITCRUSH
CK_DLL_MFUN( dist_setBits );
CK_DLL_MFUN( dist_getBits );

// sampleHold — DECIMATOR
CK_DLL_MFUN( dist_setSampleHold );
CK_DLL_MFUN( dist_getSampleHold );

// shape — WAVESHAPER
CK_DLL_MFUN( dist_setShape );
CK_DLL_MFUN( dist_getShape );

// slope — SIGMOID
CK_DLL_MFUN( dist_setSlope );
CK_DLL_MFUN( dist_getSlope );

// foldFreq — SINEFOLD
CK_DLL_MFUN( dist_setFoldFreq );
CK_DLL_MFUN( dist_getFoldFreq );

// tone — FUZZ, AMPSIM
CK_DLL_MFUN( dist_setTone );
CK_DLL_MFUN( dist_getTone );

// presence — AMPSIM
CK_DLL_MFUN( dist_setPresence );
CK_DLL_MFUN( dist_getPresence );

// asymmetry — DIODE
CK_DLL_MFUN( dist_setAsymmetry );
CK_DLL_MFUN( dist_getAsymmetry );

t_CKINT dist_data_offset = 0;

// static mode constants (exposed to ChucK)
static t_CKINT dist_HARD_CLIP  = 0;
static t_CKINT dist_SOFT_CLIP  = 1;
static t_CKINT dist_FOLDBACK   = 2;
static t_CKINT dist_TUBE       = 3;
static t_CKINT dist_ARCTANGENT = 4;
static t_CKINT dist_AMPSIM     = 5;
static t_CKINT dist_OVERDRIVE  = 6;
static t_CKINT dist_FUZZ       = 7;
static t_CKINT dist_BITCRUSH   = 8;
static t_CKINT dist_WAVESHAPER = 9;
static t_CKINT dist_DIODE      = 10;
static t_CKINT dist_SIGMOID    = 11;
static t_CKINT dist_SINEFOLD   = 12;
static t_CKINT dist_DECIMATOR  = 13;


//-----------------------------------------------------------------------------
// Distortion C++ class
//-----------------------------------------------------------------------------
class Distortion
{
public:
    enum Mode {
        HARD_CLIP  = 0,
        SOFT_CLIP  = 1,
        FOLDBACK   = 2,
        TUBE       = 3,
        ARCTANGENT = 4,
        AMPSIM     = 5,
        OVERDRIVE  = 6,
        FUZZ       = 7,
        BITCRUSH   = 8,
        WAVESHAPER = 9,
        DIODE      = 10,
        SIGMOID    = 11,
        SINEFOLD   = 12,
        DECIMATOR  = 13,
        NUM_MODES  = 14
    };

    Distortion()
    : m_mode( HARD_CLIP )
    , m_gainIn( 1.0 )
    , m_gain( 1.0 )
    , m_threshold( 0.7 )
    , m_knee( 0.2 )
    , m_foldThreshold( 0.5 )
    , m_bias( 0.1 )
    , m_warmth( 0.5 )
    , m_drive( 5.0 )
    , m_bits( 8.0 )
    , m_sampleHold( 0.5 )
    , m_shape( 0.5 )
    , m_slope( 5.0 )
    , m_foldFreq( 1.0 )
    , m_tone( 0.5 )
    , m_presence( 0.5 )
    , m_asymmetry( 0.3 )
    // state
    , m_decHoldCount( 0 )
    , m_decHoldLen( 2 )
    , m_decHoldSample( 0.0 )
    , m_toneLP( 0.0 )
    , m_ampsimLP1( 0.0 )
    , m_ampsimLP2( 0.0 )
    {
    }

    //--- tick ---
    t_CKFLOAT tick( t_CKFLOAT in )
    {
        double x = (double)in * m_gainIn;
        double y = 0.0;

        switch( m_mode )
        {
            case HARD_CLIP:  y = hardClip( x );      break;
            case SOFT_CLIP:  y = softClip( x );      break;
            case FOLDBACK:   y = foldback( x );      break;
            case TUBE:       y = tube( x );          break;
            case ARCTANGENT: y = arctangent( x );    break;
            case AMPSIM:     y = ampsim( x );        break;
            case OVERDRIVE:  y = overdrive( x );     break;
            case FUZZ:       y = fuzz( x );          break;
            case BITCRUSH:   y = bitcrush( x );      break;
            case WAVESHAPER: y = waveshaper( x );    break;
            case DIODE:      y = diode( x );         break;
            case SIGMOID:    y = sigmoid_dist( x );  break;
            case SINEFOLD:   y = sinefold( x );      break;
            case DECIMATOR:  y = decimator( x );     break;
            default:         y = x;                  break;
        }

        return (t_CKFLOAT)(y * m_gain);
    }

    //--- setters / getters ---

    t_CKINT setMode( t_CKINT v )
    {
        int clamped = (int)v;
        if( clamped < 0 ) clamped = 0;
        if( clamped >= (int)NUM_MODES ) clamped = (int)NUM_MODES - 1;
        m_mode = (Mode)clamped;
        return (t_CKINT)m_mode;
    }
    t_CKINT getMode() { return (t_CKINT)m_mode; }

    t_CKFLOAT setGainIn( t_CKFLOAT v ) { m_gainIn = (double)v; return (t_CKFLOAT)m_gainIn; }
    t_CKFLOAT getGainIn()               { return (t_CKFLOAT)m_gainIn; }

    t_CKFLOAT setGain( t_CKFLOAT v ) { m_gain = (double)v; return (t_CKFLOAT)m_gain; }
    t_CKFLOAT getGain()               { return (t_CKFLOAT)m_gain; }

    t_CKFLOAT setThreshold( t_CKFLOAT v )
    {
        m_threshold = (double)v;
        if( m_threshold < 1e-6 ) m_threshold = 1e-6;
        return (t_CKFLOAT)m_threshold;
    }
    t_CKFLOAT getThreshold() { return (t_CKFLOAT)m_threshold; }

    t_CKFLOAT setKnee( t_CKFLOAT v )
    {
        m_knee = (double)v;
        if( m_knee < 0.0 ) m_knee = 0.0;
        if( m_knee > 1.0 ) m_knee = 1.0;
        return (t_CKFLOAT)m_knee;
    }
    t_CKFLOAT getKnee() { return (t_CKFLOAT)m_knee; }

    t_CKFLOAT setFoldThreshold( t_CKFLOAT v )
    {
        m_foldThreshold = (double)v;
        if( m_foldThreshold < 1e-6 ) m_foldThreshold = 1e-6;
        return (t_CKFLOAT)m_foldThreshold;
    }
    t_CKFLOAT getFoldThreshold() { return (t_CKFLOAT)m_foldThreshold; }

    t_CKFLOAT setBias( t_CKFLOAT v )
    {
        m_bias = (double)v;
        if( m_bias < -1.0 ) m_bias = -1.0;
        if( m_bias >  1.0 ) m_bias =  1.0;
        return (t_CKFLOAT)m_bias;
    }
    t_CKFLOAT getBias() { return (t_CKFLOAT)m_bias; }

    t_CKFLOAT setWarmth( t_CKFLOAT v )
    {
        m_warmth = (double)v;
        if( m_warmth < 0.0 ) m_warmth = 0.0;
        if( m_warmth > 1.0 ) m_warmth = 1.0;
        return (t_CKFLOAT)m_warmth;
    }
    t_CKFLOAT getWarmth() { return (t_CKFLOAT)m_warmth; }

    t_CKFLOAT setDrive( t_CKFLOAT v )
    {
        m_drive = (double)v;
        if( m_drive < 1.0 ) m_drive = 1.0;
        return (t_CKFLOAT)m_drive;
    }
    t_CKFLOAT getDrive() { return (t_CKFLOAT)m_drive; }

    t_CKFLOAT setBits( t_CKFLOAT v )
    {
        m_bits = (double)v;
        if( m_bits <  1.0 ) m_bits =  1.0;
        if( m_bits > 24.0 ) m_bits = 24.0;
        return (t_CKFLOAT)m_bits;
    }
    t_CKFLOAT getBits() { return (t_CKFLOAT)m_bits; }

    t_CKFLOAT setSampleHold( t_CKFLOAT v )
    {
        m_sampleHold = (double)v;
        if( m_sampleHold < 0.0    ) m_sampleHold = 0.0;
        if( m_sampleHold > 0.9999 ) m_sampleHold = 0.9999;
        updateDecimatorHold();
        return (t_CKFLOAT)m_sampleHold;
    }
    t_CKFLOAT getSampleHold() { return (t_CKFLOAT)m_sampleHold; }

    t_CKFLOAT setShape( t_CKFLOAT v ) { m_shape = (double)v; return (t_CKFLOAT)m_shape; }
    t_CKFLOAT getShape()               { return (t_CKFLOAT)m_shape; }

    t_CKFLOAT setSlope( t_CKFLOAT v )
    {
        m_slope = (double)v;
        if( m_slope < 0.01 ) m_slope = 0.01;
        return (t_CKFLOAT)m_slope;
    }
    t_CKFLOAT getSlope() { return (t_CKFLOAT)m_slope; }

    t_CKFLOAT setFoldFreq( t_CKFLOAT v )
    {
        m_foldFreq = (double)v;
        if( m_foldFreq < 0.01 ) m_foldFreq = 0.01;
        return (t_CKFLOAT)m_foldFreq;
    }
    t_CKFLOAT getFoldFreq() { return (t_CKFLOAT)m_foldFreq; }

    t_CKFLOAT setTone( t_CKFLOAT v )
    {
        m_tone = (double)v;
        if( m_tone < 0.0 ) m_tone = 0.0;
        if( m_tone > 1.0 ) m_tone = 1.0;
        return (t_CKFLOAT)m_tone;
    }
    t_CKFLOAT getTone() { return (t_CKFLOAT)m_tone; }

    t_CKFLOAT setPresence( t_CKFLOAT v )
    {
        m_presence = (double)v;
        if( m_presence < 0.0 ) m_presence = 0.0;
        if( m_presence > 1.0 ) m_presence = 1.0;
        return (t_CKFLOAT)m_presence;
    }
    t_CKFLOAT getPresence() { return (t_CKFLOAT)m_presence; }

    t_CKFLOAT setAsymmetry( t_CKFLOAT v )
    {
        m_asymmetry = (double)v;
        if( m_asymmetry < 0.0 ) m_asymmetry = 0.0;
        if( m_asymmetry > 1.0 ) m_asymmetry = 1.0;
        return (t_CKFLOAT)m_asymmetry;
    }
    t_CKFLOAT getAsymmetry() { return (t_CKFLOAT)m_asymmetry; }

private:
    Mode   m_mode;

    // common
    double m_gainIn;
    double m_gain;

    // per-algorithm params
    double m_threshold;      // HARD_CLIP, SOFT_CLIP, SINEFOLD: clip ceiling
    double m_knee;           // SOFT_CLIP: blend factor 0=hard 1=smooth cubic
    double m_foldThreshold;  // FOLDBACK: fold / mirror point
    double m_bias;           // TUBE, OVERDRIVE: DC asymmetry offset [-1..1]
    double m_warmth;         // TUBE: even-harmonic blend [0..1]
    double m_drive;          // ARCTANGENT, OVERDRIVE: pre-gain multiplier [1..∞]
    double m_bits;           // BITCRUSH: quantisation bits [1..24]
    double m_sampleHold;     // DECIMATOR: hold ratio [0..1)
    double m_shape;          // WAVESHAPER: waveshape coefficient [0..2+]
    double m_slope;          // SIGMOID: logistic steepness
    double m_foldFreq;       // SINEFOLD: fold frequency multiplier
    double m_tone;           // FUZZ, AMPSIM: tone LP blend [0..1]
    double m_presence;       // AMPSIM: high-mid presence boost [0..1]
    double m_asymmetry;      // DIODE: positive half asymmetry [0..1]

    // state
    int    m_decHoldCount;
    int    m_decHoldLen;
    double m_decHoldSample;
    double m_toneLP;          // 1-pole LP state for FUZZ tone
    double m_ampsimLP1;       // tone LP state for AMPSIM
    double m_ampsimLP2;       // presence LP state for AMPSIM

    void updateDecimatorHold()
    {
        // sampleHold [0..1) → hold length in samples
        // 0.0 → 1 sample (pass-through)
        // 0.5 → ~2 samples (halved sample rate)
        // 0.9 → ~10 samples
        m_decHoldLen = (int)(1.0 / (1.0 - m_sampleHold + 1e-9) + 0.5);
        if( m_decHoldLen < 1 ) m_decHoldLen = 1;
    }

    //=========================================================================
    // Algorithms
    //=========================================================================

    // 0: Hard Clipping
    // Clips at ±threshold. Creates rich odd harmonics (square-wave tendency).
    // param: threshold — clip ceiling (default 0.7)
    double hardClip( double x )
    {
        if( x >  m_threshold ) return  m_threshold;
        if( x < -m_threshold ) return -m_threshold;
        return x;
    }

    // 1: Soft Clipping (cubic polynomial)
    // Three-zone saturation: linear → smooth cubic knee → hard clip.
    // knee=0 behaves like hard clip; knee=1 gives a smooth, continuous curve.
    // params: threshold — clip ceiling (default 0.7)
    //         knee      — blend 0=hard 1=smooth cubic (default 0.2)
    double softClip( double x )
    {
        double sign = (x >= 0.0) ? 1.0 : -1.0;
        // normalize to [0..∞)
        double a = fabs(x) / (m_threshold + 1e-9);

        if( a >= 1.0 ) return sign * m_threshold;   // above threshold: clamp

        // cubic soft-clip in [0,1]: slope=1 at 0, slope=0 at 1
        double soft = a * (1.5 - 0.5 * a * a);

        // blend linear (knee=0) ↔ cubic (knee=1)
        double y_norm = (1.0 - m_knee) * a + m_knee * soft;
        return sign * y_norm * m_threshold;
    }

    // 2: Foldback (mirror / wrap-around)
    // When the signal exceeds foldThreshold it folds back, creating
    // a distinctive metallic / aliased harmonic content.
    // param: foldThreshold — fold / mirror point (default 0.5)
    double foldback( double x )
    {
        double t = m_foldThreshold;
        int maxIter = 20;
        for( int i = 0; i < maxIter; i++ )
        {
            if( x >  t ) { x =  2.0 * t - x; continue; }
            if( x < -t ) { x = -2.0 * t - x; continue; }
            break;
        }
        return x;
    }

    // 3: Tube Distortion
    // Asymmetric tanh saturation with DC bias and even-harmonic warmth.
    // Positive half saturates harder, like a real tube amp.
    // params: bias   — DC offset for asymmetry [-1..1] (default 0.1)
    //         warmth — even-harmonic blend [0..1] (default 0.5)
    double tube( double x )
    {
        double xb = x + m_bias;
        // warmth adds x*|x| (even harmonic distortion)
        double warmed = xb + m_warmth * xb * fabs(xb);
        return tanh( warmed );
    }

    // 4: Arctangent
    // Smooth, frequency-independent soft saturation via atan.
    // Often used to model op-amp clipping. Pleasant on guitar.
    // param: drive — pre-gain multiplier [1..∞] (default 5.0)
    double arctangent( double x )
    {
        return (2.0 / M_PI) * atan( m_drive * x );
    }

    // 5: Amplifier Simulation
    // Three-stage model: tanh preamp → atan power amp → tone stack → presence.
    // Mimics the character of a generic valve guitar amplifier.
    // params: tone     — LP tone blend 0=dark 1=bright (default 0.5)
    //         presence — high-mid presence boost [0..1] (default 0.5)
    double ampsim( double x )
    {
        // Stage 1: preamp — tanh saturation (adds odd + even harmonics)
        double stage1 = tanh( x * 2.0 );

        // Stage 2: power amp — atan saturation (softer, more even-order)
        double stage2 = (2.0 / M_PI) * atan( stage1 * M_PI * 0.5 );

        // Tone stack: 1-pole LP; tone=0 very low-passed, tone=1 flat
        double alpha_t = 0.02 + m_tone * 0.98;   // coeff [0.02..1.0]
        m_ampsimLP1 += alpha_t * (stage2 - m_ampsimLP1);
        double toned = (1.0 - m_tone) * m_ampsimLP1 + m_tone * stage2;

        // Presence: 1-pole HP boost
        double alpha_p = 1.0 - m_presence * 0.9; // coeff [0.1..1.0]
        m_ampsimLP2 += alpha_p * (toned - m_ampsimLP2);
        double hp = toned - m_ampsimLP2;          // high-pass component
        return toned + m_presence * hp * 1.5;     // boost HP and re-add
    }

    // 6: Overdrive
    // Exponential clipping — one diode on positive, two on negative half.
    // Inspired by Tube Screamer asymmetric diode topology.
    // params: drive — amount of exponential saturation [1..∞] (default 5.0)
    //         bias  — asymmetric DC shift [-1..1] (default 0.1)
    double overdrive( double x )
    {
        double xb = x + m_bias * 0.2;
        double d  = m_drive;
        double y;
        if( xb >= 0.0 )
            y =  1.0 - exp( -d * xb );     // positive half: one diode
        else
            y = -1.0 + exp(  d * xb );     // negative half: softer
        return y;
    }

    // 7: Fuzz
    // High-gain hard clipping followed by a tone low-pass filter.
    // Inspired by Fuzz Face circuitry — produces dense square-wave harmonics.
    // param: tone — LP blend 0=very dark 1=full fuzz (default 0.5)
    double fuzz( double x )
    {
        const double FUZZ_GAIN = 20.0;
        double driven = x * FUZZ_GAIN;
        if( driven >  1.0 ) driven =  1.0;
        if( driven < -1.0 ) driven = -1.0;

        // 1-pole tone filter
        double alpha = 0.05 + 0.95 * m_tone;
        m_toneLP += alpha * (driven - m_toneLP);
        return (1.0 - m_tone) * m_toneLP + m_tone * driven;
    }

    // 8: Bitcrush
    // Reduces the dynamic resolution of the signal, simulating a lo-fi ADC.
    // param: bits — quantisation depth [1..24] (default 8.0)
    double bitcrush( double x )
    {
        double step = pow( 2.0, 1.0 - m_bits );
        return step * floor( x / step + 0.5 );
    }

    // 9: Waveshaper (Chebyshev-inspired)
    // Blends between linear → cubic soft clip → sinusoidal fold.
    // shape [0..1]: crossfade linear ↔ cubic saturation
    // shape [1..2]: crossfade cubic saturation ↔ sine folding
    // param: shape — shaping coefficient [0..2+] (default 0.5)
    double waveshaper( double x )
    {
        // hard pre-clip to -1..1 to keep the polynomial in range
        double cx = x;
        if( cx >  1.0 ) cx =  1.0;
        if( cx < -1.0 ) cx = -1.0;

        // cubic portion: slope=1 at 0, continuous at ±1
        double cubic = cx * (1.5 - 0.5 * cx * cx);

        if( m_shape <= 1.0 )
        {
            // blend linear ↔ cubic
            return (1.0 - m_shape) * cx + m_shape * cubic;
        }
        else
        {
            // blend cubic ↔ sinusoidal fold (adds more upper harmonics)
            double sinw = sin( cx * M_PI * 0.5 );
            double s = m_shape - 1.0;   // [0..1]
            return (1.0 - s) * cubic + s * sinw;
        }
    }

    // 10: Diode Clipper
    // Asymmetric exponential saturation modelling a diode-pair clipper.
    // Positive half clips harder; asymmetry controls the ratio.
    // param: asymmetry — [0..1] 0=symmetric, 1=strong asymmetry (default 0.3)
    double diode( double x )
    {
        double y;
        if( x >= 0.0 )
        {
            // positive: faster saturation with asymmetry boost
            double scale = 1.0 + m_asymmetry * 3.0;   // [1..4]
            y =  1.0 - exp( -x * scale );
        }
        else
        {
            // negative: slower saturation (less rectification)
            double scale = 1.0 - m_asymmetry * 0.5;   // [1..0.5]
            y = -(1.0 - exp(  x * scale ));
        }
        return y;
    }

    // 11: Sigmoid
    // Logistic S-curve maps input to (-1, +1). Smooth, symmetric saturation.
    // Slope controls how steep the transition zone is.
    // param: slope — steepness [0.01..∞] (default 5.0)
    double sigmoid_dist( double x )
    {
        return 2.0 / (1.0 + exp(-m_slope * x)) - 1.0;
    }

    // 12: Sinefold
    // Maps the signal through a sine function. At moderate levels it acts
    // like a soft clipper; above threshold the sine starts to fold back,
    // adding complex harmonic content.
    // params: threshold — normalisation scale (default 0.7)
    //         foldFreq  — fold frequency multiplier (default 1.0)
    double sinefold( double x )
    {
        double norm = x / (m_threshold + 1e-9);
        return sin( norm * M_PI * 0.5 * m_foldFreq );
    }

    // 13: Decimator (sample-rate reduction)
    // Holds each sample for N ticks, reducing the effective sample rate.
    // Creates lo-fi aliasing artefacts typical of vintage samplers.
    // param: sampleHold — hold ratio [0..1) 0=pass-through (default 0.5)
    double decimator( double x )
    {
        m_decHoldCount++;
        if( m_decHoldCount >= m_decHoldLen )
        {
            m_decHoldCount  = 0;
            m_decHoldSample = x;
        }
        return m_decHoldSample;
    }
};


//-----------------------------------------------------------------------------
// info
//-----------------------------------------------------------------------------
CK_DLL_INFO( Distortion )
{
    QUERY->setinfo( QUERY, CHUGIN_INFO_CHUGIN_VERSION, "1.0.0" );
    QUERY->setinfo( QUERY, CHUGIN_INFO_AUTHORS, "" );
    QUERY->setinfo( QUERY, CHUGIN_INFO_DESCRIPTION,
        "Multi-algorithm distortion: hard/soft clip, foldback, tube, "
        "arctangent, amp sim, overdrive, fuzz, bitcrush, waveshaper, "
        "diode, sigmoid, sinefold, decimator" );
}


//-----------------------------------------------------------------------------
// query — register class and methods with ChucK
//-----------------------------------------------------------------------------
CK_DLL_QUERY( Distortion )
{
    QUERY->setname( QUERY, "Distortion" );
    QUERY->begin_class( QUERY, "Distortion", "UGen" );

    // ctor / dtor / tick
    QUERY->add_ctor( QUERY, dist_ctor );
    QUERY->add_dtor( QUERY, dist_dtor );
    QUERY->add_ugen_func( QUERY, dist_tick, NULL, 1, 1 );

    // --- mode constants (read-only static ints) ---
    QUERY->add_svar( QUERY, "int", "HARD_CLIP",  true, (void*)&dist_HARD_CLIP  );
    QUERY->add_svar( QUERY, "int", "SOFT_CLIP",  true, (void*)&dist_SOFT_CLIP  );
    QUERY->add_svar( QUERY, "int", "FOLDBACK",   true, (void*)&dist_FOLDBACK   );
    QUERY->add_svar( QUERY, "int", "TUBE",       true, (void*)&dist_TUBE       );
    QUERY->add_svar( QUERY, "int", "ARCTANGENT", true, (void*)&dist_ARCTANGENT );
    QUERY->add_svar( QUERY, "int", "AMPSIM",     true, (void*)&dist_AMPSIM     );
    QUERY->add_svar( QUERY, "int", "OVERDRIVE",  true, (void*)&dist_OVERDRIVE  );
    QUERY->add_svar( QUERY, "int", "FUZZ",       true, (void*)&dist_FUZZ       );
    QUERY->add_svar( QUERY, "int", "BITCRUSH",   true, (void*)&dist_BITCRUSH   );
    QUERY->add_svar( QUERY, "int", "WAVESHAPER", true, (void*)&dist_WAVESHAPER );
    QUERY->add_svar( QUERY, "int", "DIODE",      true, (void*)&dist_DIODE      );
    QUERY->add_svar( QUERY, "int", "SIGMOID",    true, (void*)&dist_SIGMOID    );
    QUERY->add_svar( QUERY, "int", "SINEFOLD",   true, (void*)&dist_SINEFOLD   );
    QUERY->add_svar( QUERY, "int", "DECIMATOR",  true, (void*)&dist_DECIMATOR  );

    // --- mode ---
    QUERY->add_mfun( QUERY, dist_setMode, "int", "mode" );
    QUERY->add_arg( QUERY, "int", "val" );
    QUERY->add_mfun( QUERY, dist_getMode, "int", "mode" );

    // --- gainIn ---
    QUERY->add_mfun( QUERY, dist_setGainIn, "float", "gainIn" );
    QUERY->add_arg( QUERY, "float", "val" );
    QUERY->add_mfun( QUERY, dist_getGainIn, "float", "gainIn" );

    // --- gain ---
    QUERY->add_mfun( QUERY, dist_setGain, "float", "gain" );
    QUERY->add_arg( QUERY, "float", "val" );
    QUERY->add_mfun( QUERY, dist_getGain, "float", "gain" );

    // --- threshold (HARD_CLIP, SOFT_CLIP, SINEFOLD) ---
    QUERY->add_mfun( QUERY, dist_setThreshold, "float", "threshold" );
    QUERY->add_arg( QUERY, "float", "val" );
    QUERY->add_mfun( QUERY, dist_getThreshold, "float", "threshold" );

    // --- knee (SOFT_CLIP) ---
    QUERY->add_mfun( QUERY, dist_setKnee, "float", "knee" );
    QUERY->add_arg( QUERY, "float", "val" );
    QUERY->add_mfun( QUERY, dist_getKnee, "float", "knee" );

    // --- foldThreshold (FOLDBACK) ---
    QUERY->add_mfun( QUERY, dist_setFoldThreshold, "float", "foldThreshold" );
    QUERY->add_arg( QUERY, "float", "val" );
    QUERY->add_mfun( QUERY, dist_getFoldThreshold, "float", "foldThreshold" );

    // --- bias (TUBE, OVERDRIVE) ---
    QUERY->add_mfun( QUERY, dist_setBias, "float", "bias" );
    QUERY->add_arg( QUERY, "float", "val" );
    QUERY->add_mfun( QUERY, dist_getBias, "float", "bias" );

    // --- warmth (TUBE) ---
    QUERY->add_mfun( QUERY, dist_setWarmth, "float", "warmth" );
    QUERY->add_arg( QUERY, "float", "val" );
    QUERY->add_mfun( QUERY, dist_getWarmth, "float", "warmth" );

    // --- drive (ARCTANGENT, OVERDRIVE) ---
    QUERY->add_mfun( QUERY, dist_setDrive, "float", "drive" );
    QUERY->add_arg( QUERY, "float", "val" );
    QUERY->add_mfun( QUERY, dist_getDrive, "float", "drive" );

    // --- bits (BITCRUSH) ---
    QUERY->add_mfun( QUERY, dist_setBits, "float", "bits" );
    QUERY->add_arg( QUERY, "float", "val" );
    QUERY->add_mfun( QUERY, dist_getBits, "float", "bits" );

    // --- sampleHold (DECIMATOR) ---
    QUERY->add_mfun( QUERY, dist_setSampleHold, "float", "sampleHold" );
    QUERY->add_arg( QUERY, "float", "val" );
    QUERY->add_mfun( QUERY, dist_getSampleHold, "float", "sampleHold" );

    // --- shape (WAVESHAPER) ---
    QUERY->add_mfun( QUERY, dist_setShape, "float", "shape" );
    QUERY->add_arg( QUERY, "float", "val" );
    QUERY->add_mfun( QUERY, dist_getShape, "float", "shape" );

    // --- slope (SIGMOID) ---
    QUERY->add_mfun( QUERY, dist_setSlope, "float", "slope" );
    QUERY->add_arg( QUERY, "float", "val" );
    QUERY->add_mfun( QUERY, dist_getSlope, "float", "slope" );

    // --- foldFreq (SINEFOLD) ---
    QUERY->add_mfun( QUERY, dist_setFoldFreq, "float", "foldFreq" );
    QUERY->add_arg( QUERY, "float", "val" );
    QUERY->add_mfun( QUERY, dist_getFoldFreq, "float", "foldFreq" );

    // --- tone (FUZZ, AMPSIM) ---
    QUERY->add_mfun( QUERY, dist_setTone, "float", "tone" );
    QUERY->add_arg( QUERY, "float", "val" );
    QUERY->add_mfun( QUERY, dist_getTone, "float", "tone" );

    // --- presence (AMPSIM) ---
    QUERY->add_mfun( QUERY, dist_setPresence, "float", "presence" );
    QUERY->add_arg( QUERY, "float", "val" );
    QUERY->add_mfun( QUERY, dist_getPresence, "float", "presence" );

    // --- asymmetry (DIODE) ---
    QUERY->add_mfun( QUERY, dist_setAsymmetry, "float", "asymmetry" );
    QUERY->add_arg( QUERY, "float", "val" );
    QUERY->add_mfun( QUERY, dist_getAsymmetry, "float", "asymmetry" );

    // internal data offset
    dist_data_offset = QUERY->add_mvar( QUERY, "int", "@dist_data", false );

    QUERY->end_class( QUERY );
    return TRUE;
}


//-----------------------------------------------------------------------------
// ctor
//-----------------------------------------------------------------------------
CK_DLL_CTOR( dist_ctor )
{
    OBJ_MEMBER_INT( SELF, dist_data_offset ) = 0;
    Distortion * obj = new Distortion();
    OBJ_MEMBER_INT( SELF, dist_data_offset ) = (t_CKINT)obj;
}


//-----------------------------------------------------------------------------
// dtor
//-----------------------------------------------------------------------------
CK_DLL_DTOR( dist_dtor )
{
    Distortion * obj = (Distortion *)OBJ_MEMBER_INT( SELF, dist_data_offset );
    CK_SAFE_DELETE( obj );
    OBJ_MEMBER_INT( SELF, dist_data_offset ) = 0;
}


//-----------------------------------------------------------------------------
// tick
//-----------------------------------------------------------------------------
CK_DLL_TICK( dist_tick )
{
    Distortion * obj = (Distortion *)OBJ_MEMBER_INT( SELF, dist_data_offset );
    if( obj ) *out = obj->tick( in );
    return TRUE;
}


//-----------------------------------------------------------------------------
// mode
//-----------------------------------------------------------------------------
CK_DLL_MFUN( dist_setMode )
{
    Distortion * obj = (Distortion *)OBJ_MEMBER_INT( SELF, dist_data_offset );
    RETURN->v_int = obj ? obj->setMode( GET_NEXT_INT( ARGS ) ) : 0;
}
CK_DLL_MFUN( dist_getMode )
{
    Distortion * obj = (Distortion *)OBJ_MEMBER_INT( SELF, dist_data_offset );
    RETURN->v_int = obj ? obj->getMode() : 0;
}


//-----------------------------------------------------------------------------
// gainIn
//-----------------------------------------------------------------------------
CK_DLL_MFUN( dist_setGainIn )
{
    Distortion * obj = (Distortion *)OBJ_MEMBER_INT( SELF, dist_data_offset );
    RETURN->v_float = obj ? obj->setGainIn( GET_NEXT_FLOAT( ARGS ) ) : 0.0;
}
CK_DLL_MFUN( dist_getGainIn )
{
    Distortion * obj = (Distortion *)OBJ_MEMBER_INT( SELF, dist_data_offset );
    RETURN->v_float = obj ? obj->getGainIn() : 0.0;
}


//-----------------------------------------------------------------------------
// gain
//-----------------------------------------------------------------------------
CK_DLL_MFUN( dist_setGain )
{
    Distortion * obj = (Distortion *)OBJ_MEMBER_INT( SELF, dist_data_offset );
    RETURN->v_float = obj ? obj->setGain( GET_NEXT_FLOAT( ARGS ) ) : 0.0;
}
CK_DLL_MFUN( dist_getGain )
{
    Distortion * obj = (Distortion *)OBJ_MEMBER_INT( SELF, dist_data_offset );
    RETURN->v_float = obj ? obj->getGain() : 0.0;
}


//-----------------------------------------------------------------------------
// threshold
//-----------------------------------------------------------------------------
CK_DLL_MFUN( dist_setThreshold )
{
    Distortion * obj = (Distortion *)OBJ_MEMBER_INT( SELF, dist_data_offset );
    RETURN->v_float = obj ? obj->setThreshold( GET_NEXT_FLOAT( ARGS ) ) : 0.0;
}
CK_DLL_MFUN( dist_getThreshold )
{
    Distortion * obj = (Distortion *)OBJ_MEMBER_INT( SELF, dist_data_offset );
    RETURN->v_float = obj ? obj->getThreshold() : 0.0;
}


//-----------------------------------------------------------------------------
// knee
//-----------------------------------------------------------------------------
CK_DLL_MFUN( dist_setKnee )
{
    Distortion * obj = (Distortion *)OBJ_MEMBER_INT( SELF, dist_data_offset );
    RETURN->v_float = obj ? obj->setKnee( GET_NEXT_FLOAT( ARGS ) ) : 0.0;
}
CK_DLL_MFUN( dist_getKnee )
{
    Distortion * obj = (Distortion *)OBJ_MEMBER_INT( SELF, dist_data_offset );
    RETURN->v_float = obj ? obj->getKnee() : 0.0;
}


//-----------------------------------------------------------------------------
// foldThreshold
//-----------------------------------------------------------------------------
CK_DLL_MFUN( dist_setFoldThreshold )
{
    Distortion * obj = (Distortion *)OBJ_MEMBER_INT( SELF, dist_data_offset );
    RETURN->v_float = obj ? obj->setFoldThreshold( GET_NEXT_FLOAT( ARGS ) ) : 0.0;
}
CK_DLL_MFUN( dist_getFoldThreshold )
{
    Distortion * obj = (Distortion *)OBJ_MEMBER_INT( SELF, dist_data_offset );
    RETURN->v_float = obj ? obj->getFoldThreshold() : 0.0;
}


//-----------------------------------------------------------------------------
// bias
//-----------------------------------------------------------------------------
CK_DLL_MFUN( dist_setBias )
{
    Distortion * obj = (Distortion *)OBJ_MEMBER_INT( SELF, dist_data_offset );
    RETURN->v_float = obj ? obj->setBias( GET_NEXT_FLOAT( ARGS ) ) : 0.0;
}
CK_DLL_MFUN( dist_getBias )
{
    Distortion * obj = (Distortion *)OBJ_MEMBER_INT( SELF, dist_data_offset );
    RETURN->v_float = obj ? obj->getBias() : 0.0;
}


//-----------------------------------------------------------------------------
// warmth
//-----------------------------------------------------------------------------
CK_DLL_MFUN( dist_setWarmth )
{
    Distortion * obj = (Distortion *)OBJ_MEMBER_INT( SELF, dist_data_offset );
    RETURN->v_float = obj ? obj->setWarmth( GET_NEXT_FLOAT( ARGS ) ) : 0.0;
}
CK_DLL_MFUN( dist_getWarmth )
{
    Distortion * obj = (Distortion *)OBJ_MEMBER_INT( SELF, dist_data_offset );
    RETURN->v_float = obj ? obj->getWarmth() : 0.0;
}


//-----------------------------------------------------------------------------
// drive
//-----------------------------------------------------------------------------
CK_DLL_MFUN( dist_setDrive )
{
    Distortion * obj = (Distortion *)OBJ_MEMBER_INT( SELF, dist_data_offset );
    RETURN->v_float = obj ? obj->setDrive( GET_NEXT_FLOAT( ARGS ) ) : 0.0;
}
CK_DLL_MFUN( dist_getDrive )
{
    Distortion * obj = (Distortion *)OBJ_MEMBER_INT( SELF, dist_data_offset );
    RETURN->v_float = obj ? obj->getDrive() : 0.0;
}


//-----------------------------------------------------------------------------
// bits
//-----------------------------------------------------------------------------
CK_DLL_MFUN( dist_setBits )
{
    Distortion * obj = (Distortion *)OBJ_MEMBER_INT( SELF, dist_data_offset );
    RETURN->v_float = obj ? obj->setBits( GET_NEXT_FLOAT( ARGS ) ) : 0.0;
}
CK_DLL_MFUN( dist_getBits )
{
    Distortion * obj = (Distortion *)OBJ_MEMBER_INT( SELF, dist_data_offset );
    RETURN->v_float = obj ? obj->getBits() : 0.0;
}


//-----------------------------------------------------------------------------
// sampleHold
//-----------------------------------------------------------------------------
CK_DLL_MFUN( dist_setSampleHold )
{
    Distortion * obj = (Distortion *)OBJ_MEMBER_INT( SELF, dist_data_offset );
    RETURN->v_float = obj ? obj->setSampleHold( GET_NEXT_FLOAT( ARGS ) ) : 0.0;
}
CK_DLL_MFUN( dist_getSampleHold )
{
    Distortion * obj = (Distortion *)OBJ_MEMBER_INT( SELF, dist_data_offset );
    RETURN->v_float = obj ? obj->getSampleHold() : 0.0;
}


//-----------------------------------------------------------------------------
// shape
//-----------------------------------------------------------------------------
CK_DLL_MFUN( dist_setShape )
{
    Distortion * obj = (Distortion *)OBJ_MEMBER_INT( SELF, dist_data_offset );
    RETURN->v_float = obj ? obj->setShape( GET_NEXT_FLOAT( ARGS ) ) : 0.0;
}
CK_DLL_MFUN( dist_getShape )
{
    Distortion * obj = (Distortion *)OBJ_MEMBER_INT( SELF, dist_data_offset );
    RETURN->v_float = obj ? obj->getShape() : 0.0;
}


//-----------------------------------------------------------------------------
// slope
//-----------------------------------------------------------------------------
CK_DLL_MFUN( dist_setSlope )
{
    Distortion * obj = (Distortion *)OBJ_MEMBER_INT( SELF, dist_data_offset );
    RETURN->v_float = obj ? obj->setSlope( GET_NEXT_FLOAT( ARGS ) ) : 0.0;
}
CK_DLL_MFUN( dist_getSlope )
{
    Distortion * obj = (Distortion *)OBJ_MEMBER_INT( SELF, dist_data_offset );
    RETURN->v_float = obj ? obj->getSlope() : 0.0;
}


//-----------------------------------------------------------------------------
// foldFreq
//-----------------------------------------------------------------------------
CK_DLL_MFUN( dist_setFoldFreq )
{
    Distortion * obj = (Distortion *)OBJ_MEMBER_INT( SELF, dist_data_offset );
    RETURN->v_float = obj ? obj->setFoldFreq( GET_NEXT_FLOAT( ARGS ) ) : 0.0;
}
CK_DLL_MFUN( dist_getFoldFreq )
{
    Distortion * obj = (Distortion *)OBJ_MEMBER_INT( SELF, dist_data_offset );
    RETURN->v_float = obj ? obj->getFoldFreq() : 0.0;
}


//-----------------------------------------------------------------------------
// tone
//-----------------------------------------------------------------------------
CK_DLL_MFUN( dist_setTone )
{
    Distortion * obj = (Distortion *)OBJ_MEMBER_INT( SELF, dist_data_offset );
    RETURN->v_float = obj ? obj->setTone( GET_NEXT_FLOAT( ARGS ) ) : 0.0;
}
CK_DLL_MFUN( dist_getTone )
{
    Distortion * obj = (Distortion *)OBJ_MEMBER_INT( SELF, dist_data_offset );
    RETURN->v_float = obj ? obj->getTone() : 0.0;
}


//-----------------------------------------------------------------------------
// presence
//-----------------------------------------------------------------------------
CK_DLL_MFUN( dist_setPresence )
{
    Distortion * obj = (Distortion *)OBJ_MEMBER_INT( SELF, dist_data_offset );
    RETURN->v_float = obj ? obj->setPresence( GET_NEXT_FLOAT( ARGS ) ) : 0.0;
}
CK_DLL_MFUN( dist_getPresence )
{
    Distortion * obj = (Distortion *)OBJ_MEMBER_INT( SELF, dist_data_offset );
    RETURN->v_float = obj ? obj->getPresence() : 0.0;
}


//-----------------------------------------------------------------------------
// asymmetry
//-----------------------------------------------------------------------------
CK_DLL_MFUN( dist_setAsymmetry )
{
    Distortion * obj = (Distortion *)OBJ_MEMBER_INT( SELF, dist_data_offset );
    RETURN->v_float = obj ? obj->setAsymmetry( GET_NEXT_FLOAT( ARGS ) ) : 0.0;
}
CK_DLL_MFUN( dist_getAsymmetry )
{
    Distortion * obj = (Distortion *)OBJ_MEMBER_INT( SELF, dist_data_offset );
    RETURN->v_float = obj ? obj->getAsymmetry() : 0.0;
}
