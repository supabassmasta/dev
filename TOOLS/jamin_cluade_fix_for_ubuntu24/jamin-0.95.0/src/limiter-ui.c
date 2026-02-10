/*
 *  Copyright (C) 2003 Steve Harris
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
 *  $Id: limiter-ui.c,v 1.16 2005/02/06 23:31:12 jdepner Exp $
 */

#include <stdio.h>
#include <gtk/gtk.h>
#include <math.h>

#include "process.h"
#include "support.h"
#include "main.h"
#include "gtkmeter.h"
#include "state.h"
#include "db.h"

void li_changed(int id, float value);
void lh_changed(int id, float value);
void ll_changed(int id, float value);
void boost_changed(int id, float value);

static GtkAdjustment *lh_adj, *ll_adj;
static GtkLabel *lh_label, *ll_label;

static GtkMeter *in_meter, *att_meter, *out_meter;
static GtkAdjustment *in_meter_adj, *att_meter_adj, *out_meter_adj;

void bind_limiter()
{
    GtkWidget *scale;

    s_set_callback(S_LIM_INPUT, li_changed);

    scale = lookup_widget(main_window, "lim_lh_scale");
    lh_adj = gtk_range_get_adjustment(GTK_RANGE(scale));
    lh_label = GTK_LABEL(lookup_widget(main_window, "release_val_label"));
    s_set_adjustment(S_LIM_TIME, lh_adj);
    s_set_callback(S_LIM_TIME, lh_changed);

    scale = lookup_widget(main_window, "lim_out_trim_scale");
    ll_adj = gtk_range_get_adjustment(GTK_RANGE(scale));
    ll_label = GTK_LABEL(lookup_widget(main_window, "limit_val_label"));
    s_set_adjustment(S_LIM_LIMIT, ll_adj);
    s_set_callback(S_LIM_LIMIT, ll_changed);

    s_set_value(S_LIM_INPUT, 0.0f, 0);
    s_set_value(S_LIM_TIME,  0.05f, 0);
    s_set_value(S_LIM_LIMIT, 0.0f, 0);

    in_meter = GTK_METER(lookup_widget(main_window, "lim_in_meter"));
    att_meter = GTK_METER(lookup_widget(main_window, "lim_att_meter"));
    out_meter = GTK_METER(lookup_widget(main_window, "lim_out_meter"));
    in_meter_adj = gtk_meter_get_adjustment(in_meter);
    att_meter_adj = gtk_meter_get_adjustment(att_meter);
    out_meter_adj = gtk_meter_get_adjustment(out_meter);

    /* Handle waveshaper boost stuff */
    scale = lookup_widget(main_window, "boost_scale");
    s_set_adjustment(S_BOOST, gtk_range_get_adjustment(GTK_RANGE(scale)));
    s_set_callback(S_BOOST, boost_changed);
}

void li_changed(int id, float value)
{
    limiter.ingain = value;
}

void lh_changed(int id, float value)
{
    char text[256];

    const float val = powf(10.0f, value);
    if (val >= 100.0f) {
      snprintf(text, 255, _("%.3g s"), val * 0.001f);
    } else {
      snprintf(text, 255, _("%.4g ms"), val);
    }
    gtk_label_set_text(lh_label, text);

    limiter.release = powf(10.0f, value - 3.0f);
}

void ll_changed(int id, float value)
{
    char text[256];

    limiter.limit = value;
	        
    snprintf(text, 255, _("%.1f dB"), value);
    gtk_label_set_text(ll_label, text);
}

void boost_changed(int id, float value)
{
    process_set_ws_boost(value);
}

void limiter_meters_update()
{
    float peak_in = lin2db(lim_peak[LIM_PEAK_IN]);
    float peak_out = lin2db(lim_peak[LIM_PEAK_OUT]);
    float atten = -limiter.attenuation;
    lim_peak[LIM_PEAK_IN] = 0.0f;
    lim_peak[LIM_PEAK_OUT] = 0.0f;

    gtk_adjustment_set_value(in_meter_adj, peak_in);
    gtk_adjustment_set_value(att_meter_adj, atten);
    gtk_adjustment_set_value(out_meter_adj, peak_out);
}

void limiter_inmeter_reset_peak ()
{
  gtk_meter_reset_peak (in_meter);
}

void limiter_outmeter_reset_peak ()
{
  gtk_meter_reset_peak (att_meter);
  gtk_meter_reset_peak (out_meter);
}

/* vi:set ts=8 sts=4 sw=4: */
