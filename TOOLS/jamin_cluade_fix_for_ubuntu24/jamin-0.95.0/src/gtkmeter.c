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
 *  $Id: gtkmeter.c,v 1.10 2005/01/22 17:10:55 theno23 Exp $
 */

#include <math.h>
#include <stdio.h>
#include <gtk/gtkmain.h>
#include <gtk/gtksignal.h>

#include "gtkmeter.h"
#include "preferences.h"
#include "process.h"


#define METER_DEFAULT_WIDTH 10
#define METER_DEFAULT_LENGTH 100

/* Forward declarations */

static void gtk_meter_class_init               (GtkMeterClass    *klass);
static void gtk_meter_init                     (GtkMeter         *meter);
static void gtk_meter_destroy                  (GtkObject        *object);
static void gtk_meter_realize                  (GtkWidget        *widget);
static void gtk_meter_size_request             (GtkWidget      *widget,
					        GtkRequisition *requisition);
static void gtk_meter_size_allocate            (GtkWidget     *widget,
				 	        GtkAllocation *allocation);
static gint gtk_meter_expose                (GtkWidget        *widget,
						GdkEventExpose   *event);
static void gtk_meter_update                   (GtkMeter *meter);
static void gtk_meter_adjustment_changed       (GtkAdjustment    *adjustment,
						gpointer          data);
static void gtk_meter_adjustment_value_changed (GtkAdjustment    *adjustment,
						gpointer          data);

static float iec_scale(float db);


static GtkMeter *l_meter[BANDS + 20];
static int meter_count = 0;


/* Local data */

static GtkWidgetClass *parent_class = NULL;

GType
gtk_meter_get_type ()
{
  static GType meter_type = 0;

  if (!meter_type)
    {
      static const GTypeInfo meter_info =
      {
	sizeof (GtkMeterClass),
	NULL,
	NULL,
	(GClassInitFunc) gtk_meter_class_init,
	NULL,
	NULL,
	sizeof (GtkMeter),
	0,
	(GInstanceInitFunc) gtk_meter_init,
      };

      meter_type = g_type_register_static (GTK_TYPE_WIDGET, "GtkMeter", &meter_info, 0);
    }

  return meter_type;
}

static void
gtk_meter_class_init (GtkMeterClass *class)
{
  GtkObjectClass *object_class;
  GtkWidgetClass *widget_class;

  object_class = (GtkObjectClass*) class;
  widget_class = (GtkWidgetClass*) class;

  parent_class = g_type_class_peek_parent (class);

  object_class->destroy = gtk_meter_destroy;

  widget_class->realize = gtk_meter_realize;
  widget_class->expose_event = gtk_meter_expose;
  widget_class->size_request = gtk_meter_size_request;
  widget_class->size_allocate = gtk_meter_size_allocate;
}

static void
gtk_meter_init (GtkMeter *meter)
{
  meter->button = 0;
  meter->direction = GTK_METER_UP;
  meter->timer = 0;
  meter->warning_level = -6.0f;
  meter->warning_frac = 0.0f;
  meter->iec_lower = 0.0f;
  meter->iec_upper = 0.0f;
  meter->old_value = 0.0;
  meter->old_lower = 0.0;
  meter->old_upper = 0.0;
  meter->adjustment = NULL;
}

GtkWidget*
gtk_meter_new (GtkAdjustment *adjustment, gint direction)
{
  GtkMeter *meter;

  meter = g_object_new (GTK_TYPE_METER, NULL);

  if (!adjustment)
    adjustment = (GtkAdjustment*) gtk_adjustment_new (0.0, 0.0, 0.0, 0.0, 0.0, 0.0);

  gtk_meter_set_adjustment (meter, adjustment);
  meter->direction = direction;
  return GTK_WIDGET (meter);
}

static void
gtk_meter_destroy (GtkObject *object)
{
  GtkMeter *meter;

  g_return_if_fail (object != NULL);
  g_return_if_fail (GTK_IS_METER (object));

  meter = GTK_METER (object);

  if (meter->adjustment)
    g_object_unref (G_OBJECT (meter->adjustment));

  if (GTK_OBJECT_CLASS (parent_class)->destroy)
    (* GTK_OBJECT_CLASS (parent_class)->destroy) (object);
}

GtkAdjustment*
gtk_meter_get_adjustment (GtkMeter *meter)
{
  g_return_val_if_fail (meter != NULL, NULL);
  g_return_val_if_fail (GTK_IS_METER (meter), NULL);

  return meter->adjustment;
}

void
gtk_meter_set_adjustment (GtkMeter      *meter,
			  GtkAdjustment *adjustment)
{
  g_return_if_fail (meter != NULL);
  g_return_if_fail (GTK_IS_METER (meter));

  if (meter->adjustment)
    {
      g_signal_handlers_disconnect_by_data (meter->adjustment, (gpointer) meter);
      g_object_unref (G_OBJECT (meter->adjustment));
    }

  meter->adjustment = adjustment;
  g_object_ref (G_OBJECT (meter->adjustment));

  g_signal_connect (G_OBJECT (adjustment), "changed",
		      G_CALLBACK (gtk_meter_adjustment_changed),
		      (gpointer) meter);
  g_signal_connect (G_OBJECT (adjustment), "value_changed",
		      G_CALLBACK (gtk_meter_adjustment_value_changed),
		      (gpointer) meter);

  meter->old_value = adjustment->value;
  meter->old_lower = adjustment->lower;
  meter->old_upper = adjustment->upper;
  meter->iec_lower = iec_scale(adjustment->lower);
  meter->iec_upper = iec_scale(adjustment->upper);
  meter->warning_frac = (iec_scale(meter->warning_level) - meter->iec_lower) /
	            (meter->iec_upper - meter->iec_lower);

  gtk_meter_update (meter);
}

static void
gtk_meter_realize (GtkWidget *widget)
{
  GtkMeter *meter;
  GdkWindowAttr attributes;
  gint attributes_mask;

  g_return_if_fail (widget != NULL);
  g_return_if_fail (GTK_IS_METER (widget));

  GTK_WIDGET_SET_FLAGS (widget, GTK_REALIZED);
  meter = GTK_METER (widget);


  /*  Save meter widget for later color adjustment.  */

  l_meter[meter_count++] = meter;


  attributes.x = widget->allocation.x;
  attributes.y = widget->allocation.y;
  attributes.width = widget->allocation.width;
  attributes.height = widget->allocation.height;
  attributes.wclass = GDK_INPUT_OUTPUT;
  attributes.window_type = GDK_WINDOW_CHILD;
  attributes.event_mask = gtk_widget_get_events (widget) | GDK_EXPOSURE_MASK;
  attributes.visual = gtk_widget_get_visual (widget);

  attributes_mask = GDK_WA_X | GDK_WA_Y | GDK_WA_VISUAL;
  widget->window = gdk_window_new (widget->parent->window, &attributes, attributes_mask);

  widget->style = gtk_style_attach (widget->style, widget->window);

  gdk_window_set_user_data (widget->window, widget);

  gtk_style_set_background (widget->style, widget->window, GTK_STATE_ACTIVE);

  meter->normal_gc = gdk_gc_new(widget->window);
  gdk_gc_set_foreground(meter->normal_gc, get_color (METER_NORMAL_COLOR));

  meter->warning_gc = gdk_gc_new(widget->window);
  gdk_gc_set_foreground(meter->warning_gc, get_color (METER_WARNING_COLOR));

  meter->over_gc = gdk_gc_new(widget->window);
  gdk_gc_set_foreground(meter->over_gc, get_color (METER_OVER_COLOR));

  meter->peak_gc = gdk_gc_new(widget->window);
  gdk_gc_set_foreground(meter->peak_gc, get_color (METER_PEAK_COLOR));
}

static void 
gtk_meter_size_request (GtkWidget      *widget,
		       GtkRequisition *requisition)
{
  GtkMeter *meter = GTK_METER(widget);

  if (meter->direction == GTK_METER_UP || meter->direction == GTK_METER_DOWN) {
    requisition->width = METER_DEFAULT_WIDTH;
    requisition->height = METER_DEFAULT_LENGTH;
  } else {
    requisition->width = METER_DEFAULT_LENGTH;
    requisition->height = METER_DEFAULT_WIDTH;
  }
}

static void
gtk_meter_size_allocate (GtkWidget     *widget,
			GtkAllocation *allocation)
{
  GtkMeter *meter;

  g_return_if_fail (widget != NULL);
  g_return_if_fail (GTK_IS_METER (widget));
  g_return_if_fail (allocation != NULL);

  widget->allocation = *allocation;
  meter = GTK_METER (widget);

  if (GTK_WIDGET_REALIZED (widget))
    {

      gdk_window_move_resize (widget->window,
			      allocation->x, allocation->y,
			      allocation->width, allocation->height);

    }
}

static gint
gtk_meter_expose (GtkWidget      *widget,
		 GdkEventExpose *event)
{
  GtkMeter *meter;
  float val, frac, peak_frac;
  int g_h, a_h, r_h;
  int length = 0, width = 0;

  g_return_val_if_fail (widget != NULL, FALSE);
  g_return_val_if_fail (GTK_IS_METER (widget), FALSE);
  g_return_val_if_fail (event != NULL, FALSE);

  if (event->count > 0)
    return FALSE;
  
  meter = GTK_METER (widget);

  switch (meter->direction) {
    case GTK_METER_UP:
    case GTK_METER_DOWN:
      length = widget->allocation.height - 2;
      width = widget->allocation.width - 2;
      break;
    case GTK_METER_LEFT:
    case GTK_METER_RIGHT:
      length = widget->allocation.width - 2;
      width = widget->allocation.height - 2;
      break;
  }

  val = iec_scale(meter->adjustment->value);
  if (val > meter->peak) {
    if (val > meter->iec_upper) {
      meter->peak = meter->iec_upper;
    } else {
      meter->peak = val;
    }
  }

  frac = (val - meter->iec_lower) / (meter->iec_upper - meter->iec_lower);
  peak_frac = (meter->peak - meter->iec_lower) / (meter->iec_upper -
		  meter->iec_lower);

  /* Draw the background */
  gtk_paint_box (widget->style, widget->window, GTK_STATE_NORMAL,
		  GTK_SHADOW_IN, NULL, widget, "trough", 0, 0,
		  widget->allocation.width, widget->allocation.height);


  if (frac < meter->warning_frac) {
    g_h = frac * length;
    a_h = g_h;
    r_h = g_h;
  } else if (val <= 100.0f) {
    g_h = meter->warning_frac * length;
    a_h = frac * length;
    r_h = a_h;
  } else {
    g_h = meter->warning_frac * length;
    a_h = length * (100.0f - meter->iec_lower) / (meter->iec_upper -
		    meter->iec_lower);
    r_h = frac * length;
  }

  if (a_h > length) {
    a_h = length;
  }
  if (r_h > length) {
    r_h = length;
  }

  switch (meter->direction) {
    case GTK_METER_LEFT:
      gdk_draw_rectangle (widget->window, meter->warning_gc, TRUE, a_h +
		      1, 1, length - a_h, width);
      /*
      gdk_draw_rectangle (widget->window, meter->peak_gc, TRUE, length *
		      (1.0 - peak_frac) + 1, 1, 1, width);
		      */
      break;

    case GTK_METER_RIGHT:
      gdk_draw_rectangle (widget->window, meter->normal_gc, TRUE, 1, 1,
		      g_h, width);
      if (a_h > g_h) {
	gdk_draw_rectangle (widget->window, meter->warning_gc, TRUE, 1+g_h, 1,
			a_h - g_h, width);
      }
      if (r_h > a_h) {
	gdk_draw_rectangle (widget->window, meter->over_gc, TRUE, 1+a_h, 1,
			r_h - a_h, width);
      }
      gdk_draw_rectangle (widget->window, meter->peak_gc, TRUE, length *
		      peak_frac, 1, 1, width);
      break;

    case GTK_METER_UP:
    default:
      gdk_draw_rectangle (widget->window, meter->normal_gc, TRUE, 1, length -
		      g_h + 1, width, g_h);
      if (a_h > g_h) {
	gdk_draw_rectangle (widget->window, meter->warning_gc, TRUE, 1, length -
			a_h + 1, width, a_h - g_h);
      }
      if (r_h > a_h) {
	gdk_draw_rectangle (widget->window, meter->over_gc, TRUE, 1, length -
			r_h + 1, width, r_h - a_h);
      }
      if (peak_frac > 0) {
        gdk_draw_rectangle (widget->window, meter->peak_gc, TRUE, 1, length *
		      (1.0f - peak_frac) + 1, width, 1);
      }
      break;
  }
  
  return FALSE;
}

static void
gtk_meter_update (GtkMeter *meter)
{
  gfloat new_value;
  
  g_return_if_fail (meter != NULL);
  g_return_if_fail (GTK_IS_METER (meter));

  new_value = meter->adjustment->value;
  
  if (new_value < meter->adjustment->lower)
    new_value = meter->adjustment->lower;

  if (new_value > meter->adjustment->upper)
    new_value = meter->adjustment->upper;

  if (new_value != meter->adjustment->value)
    {
      meter->adjustment->value = new_value;
      //gtk_signal_emit_by_name (GTK_OBJECT (meter->adjustment),
      //		         "value_changed");
    }

  gtk_widget_draw(GTK_WIDGET(meter), NULL);
}

static void
gtk_meter_adjustment_changed (GtkAdjustment *adjustment,
			      gpointer       data)
{
  GtkMeter *meter;

  g_return_if_fail (adjustment != NULL);
  g_return_if_fail (data != NULL);

  meter = GTK_METER (data);

  if ((meter->old_lower != adjustment->lower) ||
      (meter->old_upper != adjustment->upper))
    {
      meter->iec_lower = iec_scale(adjustment->lower);
      meter->iec_upper = iec_scale(adjustment->upper);

      gtk_meter_set_warn_point(meter, meter->warning_level);

      gtk_meter_update (meter);

      meter->old_value = adjustment->value;
      meter->old_lower = adjustment->lower;
      meter->old_upper = adjustment->upper;
    } else if (meter->old_value != adjustment->value) {
      gtk_meter_update (meter);

      meter->old_value = adjustment->value;
    }
}

static void
gtk_meter_adjustment_value_changed (GtkAdjustment *adjustment,
				    gpointer       data)
{
  GtkMeter *meter;

  g_return_if_fail (adjustment != NULL);
  g_return_if_fail (data != NULL);

  meter = GTK_METER (data);

  if (meter->old_value != adjustment->value)
    {
      gtk_meter_update (meter);

      meter->old_value = adjustment->value;
    }
}

static float iec_scale(float db)
{
    float def = 0.0f;		/* Meter deflection %age */

    if (db < -70.0f) {
	def = 0.0f;
    } else if (db < -60.0f) {
	def = (db + 70.0f) * 0.25f;
    } else if (db < -50.0f) {
	def = (db + 60.0f) * 0.5f + 2.5f;
    } else if (db < -40.0f) {
	def = (db + 50.0f) * 0.75f + 7.5f;
    } else if (db < -30.0f) {
	def = (db + 40.0f) * 1.5f + 15.0f;
    } else if (db < -20.0f) {
	def = (db + 30.0f) * 2.0f + 30.0f;
    } else {
	def = (db + 20.0f) * 2.5f + 50.0f;
    }

    return def;
}

void gtk_meter_reset_peak(GtkMeter *meter)
{
    meter->peak = 0.0f;
}

void gtk_meter_set_warn_point(GtkMeter *meter, gfloat pt)
{
    meter->warning_level = pt;
    if (meter->direction == GTK_METER_LEFT || meter->direction ==
		    GTK_METER_DOWN) {
	meter->warning_frac = 1.0f - (iec_scale(meter->warning_level) -
		meter->iec_lower) / (meter->iec_upper - meter->iec_lower);
    } else {
        meter->warning_frac = (iec_scale(meter->warning_level) - meter->iec_lower) /
		(meter->iec_upper - meter->iec_lower);
    }

    gtk_widget_draw(GTK_WIDGET(meter), NULL);
}

void gtk_meter_set_color (int color_id)
{
  int    i;


  for (i = 0 ; i < meter_count ; i++)
    {
      switch (color_id)
        {
        case METER_NORMAL_COLOR:
          gdk_gc_set_foreground(l_meter[i]->normal_gc, 
                                get_color (METER_NORMAL_COLOR));
          break;

        case METER_WARNING_COLOR:
          gdk_gc_set_foreground(l_meter[i]->warning_gc, 
                                get_color (METER_WARNING_COLOR));
          break;


        case METER_OVER_COLOR:
          gdk_gc_set_foreground(l_meter[i]->over_gc, 
                                get_color (METER_OVER_COLOR));
          break;


        case METER_PEAK_COLOR:
          gdk_gc_set_foreground(l_meter[i]->peak_gc, 
                                get_color (METER_PEAK_COLOR));
          break;
        }
    }
}
