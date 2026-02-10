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
 *  $Id: intrim.c,v 1.15 2005/02/06 23:31:11 jdepner Exp $
 */

#include <gtk/gtk.h>
#include <math.h>
#include <stdio.h>

#include "process.h"
#include "support.h"
#include "main.h"
#include "intrim.h"
#include "gtkmeter.h"
#include "state.h"
#include "db.h"

static GtkMeter *in_meter[2], *out_meter[2];
static GtkAdjustment *in_meter_adj[2], *out_meter_adj[2];
static GtkLabel	*pan_label;

void intrim_cb(int id, float value);
void outtrim_cb(int id, float value);
void inpan_cb(int id, float value);

float in_gain[2] = {1.0f, 1.0f};
float out_gain = 1.0f;
float in_trim_gain = 1.0f;
float in_pan_gain[2] = {1.0f, 1.0f};

void bind_intrim()
{
    in_meter[0] = GTK_METER(lookup_widget(main_window, "inmeter_l"));
    in_meter[1] = GTK_METER(lookup_widget(main_window, "inmeter_r"));
    in_meter_adj[0] = gtk_meter_get_adjustment(in_meter[0]);
    in_meter_adj[1] = gtk_meter_get_adjustment(in_meter[1]);
    gtk_adjustment_set_value(in_meter_adj[0], -60.0);
    gtk_adjustment_set_value(in_meter_adj[1], -60.0);

    out_meter[0] = GTK_METER(lookup_widget(main_window, "outmeter_l"));
    out_meter[1] = GTK_METER(lookup_widget(main_window, "outmeter_r"));
    out_meter_adj[0] = gtk_meter_get_adjustment(out_meter[0]);
    out_meter_adj[1] = gtk_meter_get_adjustment(out_meter[1]);
    gtk_adjustment_set_value(out_meter_adj[0], -60.0);
    gtk_adjustment_set_value(out_meter_adj[1], -60.0);

    pan_label = GTK_LABEL(lookup_widget(main_window, "pan_label"));
    update_pan_label(0.0);

    s_set_callback(S_IN_GAIN, intrim_cb);
    s_set_adjustment(S_IN_GAIN, gtk_range_get_adjustment(GTK_RANGE(lookup_widget(main_window, "in_trim_scale"))));

    s_set_callback(S_OUT_GAIN, outtrim_cb);
    s_set_adjustment(S_OUT_GAIN, gtk_range_get_adjustment(GTK_RANGE(lookup_widget(main_window, "out_trim_scale"))));

    s_set_callback(S_IN_PAN, inpan_cb);
    s_set_adjustment(S_IN_PAN, gtk_range_get_adjustment(GTK_RANGE(lookup_widget(main_window, "pan_scale"))));
}

void intrim_cb(int id, float value)
{
    in_trim_gain = db2lin(value);
    in_gain[0] = in_trim_gain * in_pan_gain[0];
    in_gain[1] = in_trim_gain * in_pan_gain[1];
}

void outtrim_cb(int id, float value)
{
    out_gain = db2lin(value);
}

void inpan_cb(int id, float value)
{
    in_pan_gain[0] = db2lin(value * -0.5f);
    in_pan_gain[1] = db2lin(value * 0.5f);
    in_gain[0] = in_trim_gain * in_pan_gain[0];
    in_gain[1] = in_trim_gain * in_pan_gain[1];
    update_pan_label(value);
}

void in_meter_value(float amp[])
{
    gtk_adjustment_set_value(in_meter_adj[0], lin2db(amp[0]));
    gtk_adjustment_set_value(in_meter_adj[1], lin2db(amp[1]));
    amp[0] = 0.0f;
    amp[1] = 0.0f;
}

void out_meter_value(float amp[])
{
    gtk_adjustment_set_value(out_meter_adj[0], lin2db(amp[0]));
    gtk_adjustment_set_value(out_meter_adj[1], lin2db(amp[1]));
    amp[0] = 0.0f;
    amp[1] = 0.0f;
}

void update_pan_label(float balance)
{
    char tmp[256];

    if (balance < -0.5f) {
      snprintf(tmp, 255, _("left %.0fdB"), -balance);
    } else if (balance > 0.5f) {
      snprintf(tmp, 255, _("right %.0fdB"), balance);
    } else {
      sprintf(tmp, _("centre"));
    }
    gtk_label_set_label(pan_label, tmp);
}

void intrim_inmeter_reset_peak ()
{
  gtk_meter_reset_peak (in_meter[0]);
  gtk_meter_reset_peak (in_meter[1]);
}

void intrim_outmeter_reset_peak ()
{
  gtk_meter_reset_peak (out_meter[0]);
  gtk_meter_reset_peak (out_meter[1]);
}

/* vi:set ts=8 sts=4 sw=4: */
