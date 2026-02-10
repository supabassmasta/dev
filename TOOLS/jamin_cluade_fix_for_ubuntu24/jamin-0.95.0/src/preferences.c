/*
 *  preferences.c -- Preferences (color, crossfade time) dialog.
 *
 *  Copyright (C) 2004 Jan C. Depner.
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
 *  You should have received a copy of the GNU General Public License
 *  along with this program; if not, write to the Free Software
 *  Foundation, Inc., 675 Mass Ave, Cambridge, MA 02139, USA.
 */


#include <stdio.h>
#include <stdlib.h>
#include <unistd.h>
#include <time.h>
#include <sys/times.h>
#include <errno.h>
#include <math.h>
#include <string.h>
#include <gtk/gtk.h>


#include "preferences.h"
#include "hdeq.h"
#include "main.h"
#include "help.h"
#include "interface.h"
#include "support.h"
#include "process.h"
#include "compressor-ui.h"
#include "state.h"
#include "spectrum.h"
#include "gtkmeter.h"


static char color_help[] = {
"    This is a standard color selection dialog.  Push buttons and see what \
happens.  If you don't like the color just press cancel.  When you've got \
the color you want (fuschia, puce, chartreuse, whatever) just press OK.\n"
};


static GtkWidget         *pref_dialog, *color_dialog, *colorsel;
static GdkColormap       *colormap = NULL;
static GdkColor          color[COLORS];
static int               color_id;
static GtkSpinButton     *ct_spin, *lgain_spin, *ugain_spin, *spec_freq_spin;
static GtkRadioButton    *iir_button, *fft_button;
static GtkToggleButton   *t_iir, *t_fft;
static GtkMenu           *l_menu3;


static void color_ok_callback (GtkWidget *w, gpointer user_data);
static void color_cancel_callback (GtkWidget *w, gpointer user_data);
static void color_help_callback (GtkWidget *w, gpointer user_data);


/*  Just like fgets but strips trailing LF/CR.  */

char *ngets (char *s, int size, FILE *stream)
{
    if (fgets (s, size, stream) == NULL) return (NULL);

    while( strlen(s)>0 && (s[strlen(s)-1] == '\n' || 
                           s[strlen(s)-1] == '\r') )
      s[strlen(s)-1] = '\0';

    if (s[strlen (s) - 1] == '\n') s[strlen (s) - 1] = 0;


    return (s);
}


void preferences_init()
{
    char            varin[128], info[128], file[512];
    FILE            *fp = NULL;
    unsigned short  i, j, k;


    pref_dialog = create_pref_dialog ();

    lgain_spin = GTK_SPIN_BUTTON (lookup_widget (pref_dialog, 
                                                "MinGainSpin"));
    ugain_spin = GTK_SPIN_BUTTON (lookup_widget (pref_dialog, 
                                                "MaxGainSpin"));
    spec_freq_spin = GTK_SPIN_BUTTON (lookup_widget (pref_dialog, 
                                                "UpdateFrequencySpin"));
    l_menu3 = GTK_MENU (lookup_widget (pref_dialog, "menu3"));


    ct_spin = GTK_SPIN_BUTTON (lookup_widget (pref_dialog, 
                                              "CrossfadeTimeSpin"));

    iir_button = GTK_RADIO_BUTTON (lookup_widget (pref_dialog, 
						   "IIRButton"));
    fft_button = GTK_RADIO_BUTTON (lookup_widget (pref_dialog, 
						   "FFTButton"));
    t_iir = &iir_button->check_button.toggle_button;
    t_fft = &fft_button->check_button.toggle_button;

    color_dialog = create_colorselectiondialog1 ();

    colorsel = GTK_COLOR_SELECTION_DIALOG (color_dialog)->colorsel;

    g_signal_connect (GTK_OBJECT 
                      (GTK_COLOR_SELECTION_DIALOG (color_dialog)->ok_button),
                      "clicked", G_CALLBACK (color_ok_callback), color_dialog);

    g_signal_connect (GTK_OBJECT 
                      (GTK_COLOR_SELECTION_DIALOG (color_dialog)->cancel_button),
                      "clicked", G_CALLBACK (color_cancel_callback), color_dialog);

    g_signal_connect (GTK_OBJECT 
                      (GTK_COLOR_SELECTION_DIALOG (color_dialog)->help_button),
                      "clicked", G_CALLBACK (color_help_callback), color_dialog);


    colormap = gdk_colormap_get_system ();


    /*  Set all of the colors to the defaults in case someone has edited the
        ~/.jamin-defaults file and removed (or hosed) one or more of the
        entries.  */

    pref_reset_all_colors ();


    /*  Get user colors and possibly other things from the jamin-defaults 
        file.  */

    if (jamin_dir)
      {
        strcpy (file, jamin_dir);
        strcat (file, "jamin-defaults");
      }
    else
      {
        return;
      }

    if ((fp = fopen (file, "r")) != NULL)
      {
        /*  Read each entry.    */
        
        while (ngets (varin, sizeof (varin), fp) != NULL)
          {
            /*  Put everything to the right of the equals sign in 'info'.  */
            
            if (strchr (varin, '=') != NULL)
              strcpy (info, (strchr (varin, '=') + 1));


            /*  Check input for matching strings and load values if
                found.  */
            
            if (strstr (varin, "[TEXT COLOR]") != NULL)
              {
                sscanf (info, "%hu %hu %hu", &i, &j, &k);
                set_color (&color[TEXT_COLOR], i, j, k);
              }

            if (strstr (varin, "[LOW BAND COMPRESSOR COLOR]") != NULL)
              {
                sscanf (info, "%hu %hu %hu", &i, &j, &k);
                set_color (&color[LOW_BAND_COLOR], i, j, k);
              }

            if (strstr (varin, "[MID BAND COMPRESSOR COLOR]") != NULL)
              {
                sscanf (info, "%hu %hu %hu", &i, &j, &k);
                set_color (&color[MID_BAND_COLOR], i, j, k);
              }

            if (strstr (varin, "[HIGH BAND COMPRESSOR COLOR]") != NULL)
              {
                sscanf (info, "%hu %hu %hu", &i, &j, &k);
                set_color (&color[HIGH_BAND_COLOR], i, j, k);
              }

            if (strstr (varin, "[GANG HIGHLIGHT COLOR]") != NULL)
              {
                sscanf (info, "%hu %hu %hu", &i, &j, &k);
                set_color (&color[GANG_HIGHLIGHT_COLOR], i, j, k);
              }

            if (strstr (varin, "[PARAMETRIC HANDLE COLOR]") != NULL)
              {
                sscanf (info, "%hu %hu %hu", &i, &j, &k);
                set_color (&color[HANDLE_COLOR], i, j, k);
              }

            if (strstr (varin, "[HDEQ CURVE COLOR]") != NULL)
              {
                sscanf (info, "%hu %hu %hu", &i, &j, &k);
                set_color (&color[HDEQ_CURVE_COLOR], i, j, k);
              }

            if (strstr (varin, "[HDEQ GRID COLOR]") != NULL)
              {
                sscanf (info, "%hu %hu %hu", &i, &j, &k);
                set_color (&color[HDEQ_GRID_COLOR], i, j, k);
              }

            if (strstr (varin, "[HDEQ BACKGROUND COLOR]") != NULL)
              {
                sscanf (info, "%hu %hu %hu", &i, &j, &k);
                set_color (&color[HDEQ_BACKGROUND_COLOR], i, j, k);
              }

            if (strstr (varin, "[METER NORMAL COLOR]") != NULL)
              {
                sscanf (info, "%hu %hu %hu", &i, &j, &k);
                set_color (&color[METER_NORMAL_COLOR], i, j, k);
              }

            if (strstr (varin, "[METER WARNING COLOR]") != NULL)
              {
                sscanf (info, "%hu %hu %hu", &i, &j, &k);
                set_color (&color[METER_WARNING_COLOR], i, j, k);
              }

            if (strstr (varin, "[METER OVER COLOR]") != NULL)
              {
                sscanf (info, "%hu %hu %hu", &i, &j, &k);
                set_color (&color[METER_OVER_COLOR], i, j, k);
              }

            if (strstr (varin, "[METER PEAK COLOR]") != NULL)
              {
                sscanf (info, "%hu %hu %hu", &i, &j, &k);
                set_color (&color[METER_PEAK_COLOR], i, j, k);
              }
          }

        fclose (fp);
      }
}


GdkColor *get_color (int color_id)
{
  return (&color[color_id]);
}


/*  Generic color setting.  */

void set_color (GdkColor *color, unsigned short red, unsigned short green, 
                unsigned short blue)
{
    color->red = red;
    color->green = green;
    color->blue = blue;

    gdk_colormap_alloc_color (colormap, color, FALSE, TRUE);
}


/*  Pop up the EQ options dialog.  */

void popup_pref_dialog (int updown)
{
  /*  Pop up on 1.  */

  if (updown)
    {
      gtk_spin_button_set_value (ct_spin, s_get_crossfade_time());

      gtk_spin_button_set_value (lgain_spin, hdeq_get_lower_gain ());
      gtk_spin_button_set_value (ugain_spin, hdeq_get_upper_gain ());
      gtk_spin_button_set_value (spec_freq_spin, get_spectrum_freq ());

      gtk_menu_set_active (l_menu3, process_get_spec_mode());

      if (process_get_crossover_type() == IIR)
	{
	  gtk_toggle_button_set_active (t_iir, TRUE);
	  gtk_toggle_button_set_active (t_fft, FALSE);
	}
      else
	{
	  gtk_toggle_button_set_active (t_iir, FALSE);
	  gtk_toggle_button_set_active (t_fft, TRUE);
	}


      gtk_widget_show (pref_dialog);
    }


  /*  Pop down on 0.  */

  else
    {
      gtk_widget_hide (pref_dialog);
    }
}


/*  Pop up the color dialog.  */

void popup_color_dialog (int id)
{
  GdkColor *ptr;

  color_id = id;

  ptr = &color[id];


  gtk_color_selection_set_current_color ((GtkColorSelection *) colorsel, ptr);


  gtk_widget_show (color_dialog);
}


void pref_force_color_change ()
{
  static GdkRectangle rect;


  repaint_gang_labels ();
  draw_EQ_curve ();


  /*  Force all compressor curves.  */

  draw_comp_curve (0);
  draw_comp_curve (1);
  draw_comp_curve (2);


  /*  Force all meter redraws.  */

  gtk_meter_set_color (METER_NORMAL_COLOR);
  gtk_meter_set_color (METER_WARNING_COLOR);
  gtk_meter_set_color (METER_OVER_COLOR);
  gtk_meter_set_color (METER_PEAK_COLOR);


  /*  Force an expose to change the text color.  */

  rect.x = main_window->allocation.x;
  rect.y = main_window->allocation.y;
  rect.width = main_window->allocation.width;
  rect.height = main_window->allocation.height;

  gdk_window_invalidate_rect (main_window->window, &rect, TRUE);
  gdk_window_process_updates (main_window->window, TRUE);
}


static void color_ok_callback (GtkWidget *w, gpointer user_data)
{
  GdkColor l_color;


  gtk_color_selection_get_current_color ((GtkColorSelection *) colorsel, 
                                         &l_color);

  set_color (&color[color_id], l_color.red, l_color.green, l_color.blue);

  pref_force_color_change ();

  gtk_widget_hide (color_dialog);
}


static void color_cancel_callback (GtkWidget *w, gpointer user_data)
{
  gtk_widget_hide (color_dialog);
}


static void color_help_callback (GtkWidget *w, gpointer user_data)
{
  message (GTK_MESSAGE_INFO, color_help);
}


void pref_write_jamin_defaults ()
{
    char     file[512];
    FILE     *fp = NULL;


    if (jamin_dir)
      {
        strcpy (file, jamin_dir);
        strcat (file, "jamin-defaults");
      }
    else
      {
        return;
      }
     
    if ((fp = fopen (file, "w")) != NULL)
      {
        fprintf (fp, "JAMin defaults file V%s\n",  VERSION);

        fprintf (fp, "[TEXT COLOR]                 = %hu %hu %hu\n",
                 color[TEXT_COLOR].red, 
                 color[TEXT_COLOR].green,
                 color[TEXT_COLOR].blue);

        fprintf (fp, "[LOW BAND COMPRESSOR COLOR]  = %hu %hu %hu\n",
                 color[LOW_BAND_COLOR].red, 
                 color[LOW_BAND_COLOR].green,
                 color[LOW_BAND_COLOR].blue);

        fprintf (fp, "[MID BAND COMPRESSOR COLOR]  = %hu %hu %hu\n",
                 color[MID_BAND_COLOR].red, 
                 color[MID_BAND_COLOR].green,
                 color[MID_BAND_COLOR].blue);

        fprintf (fp, "[HIGH BAND COMPRESSOR COLOR] = %hu %hu %hu\n",
                 color[HIGH_BAND_COLOR].red, 
                 color[HIGH_BAND_COLOR].green,
                 color[HIGH_BAND_COLOR].blue);

        fprintf (fp, "[GANG HIGHLIGHT COLOR]       = %hu %hu %hu\n",
                 color[GANG_HIGHLIGHT_COLOR].red, 
                 color[GANG_HIGHLIGHT_COLOR].green,
                 color[GANG_HIGHLIGHT_COLOR].blue);

        fprintf (fp, "[PARAMETRIC HANDLE COLOR]    = %hu %hu %hu\n",
                 color[HANDLE_COLOR].red, 
                 color[HANDLE_COLOR].green,
                 color[HANDLE_COLOR].blue);

        fprintf (fp, "[HDEQ CURVE COLOR]           = %hu %hu %hu\n",
                 color[HDEQ_CURVE_COLOR].red, 
                 color[HDEQ_CURVE_COLOR].green,
                 color[HDEQ_CURVE_COLOR].blue);

        fprintf (fp, "[HDEQ GRID COLOR]            = %hu %hu %hu\n",
                 color[HDEQ_GRID_COLOR].red, 
                 color[HDEQ_GRID_COLOR].green,
                 color[HDEQ_GRID_COLOR].blue);

        fprintf (fp, "[HDEQ BACKGROUND COLOR]      = %hu %hu %hu\n",
                 color[HDEQ_BACKGROUND_COLOR].red, 
                 color[HDEQ_BACKGROUND_COLOR].green,
                 color[HDEQ_BACKGROUND_COLOR].blue);

        fprintf (fp, "[METER NORMAL COLOR]         = %hu %hu %hu\n",
                 color[METER_NORMAL_COLOR].red, 
                 color[METER_NORMAL_COLOR].green,
                 color[METER_NORMAL_COLOR].blue);

        fprintf (fp, "[METER WARNING COLOR]        = %hu %hu %hu\n",
                 color[METER_WARNING_COLOR].red, 
                 color[METER_WARNING_COLOR].green,
                 color[METER_WARNING_COLOR].blue);

        fprintf (fp, "[METER OVER COLOR]           = %hu %hu %hu\n",
                 color[METER_OVER_COLOR].red, 
                 color[METER_OVER_COLOR].green,
                 color[METER_OVER_COLOR].blue);

        fprintf (fp, "[METER PEAK COLOR]           = %hu %hu %hu\n",
                 color[METER_PEAK_COLOR].red, 
                 color[METER_PEAK_COLOR].green,
                 color[METER_PEAK_COLOR].blue);

        fclose (fp);
      }
}


void pref_reset_all_colors ()
{
  set_color (&color[TEXT_COLOR], 0, 0, 0);
  set_color (&color[LOW_BAND_COLOR], 0, 50000, 0);
  set_color (&color[MID_BAND_COLOR], 0, 0, 60000);
  set_color (&color[HIGH_BAND_COLOR], 60000, 0, 0);
  set_color (&color[GANG_HIGHLIGHT_COLOR], 65535, 0, 0);

  set_color (&color[HANDLE_COLOR], 65535, 65535, 0);
  set_color (&color[HDEQ_CURVE_COLOR], 65535, 65535, 65535);
  set_color (&color[HDEQ_GRID_COLOR], 0, 36611, 0);
  set_color (&color[HDEQ_SPECTRUM_COLOR], 32768, 32768, 32768);
  set_color (&color[HDEQ_BACKGROUND_COLOR], 0, 21611, 0);
  set_color (&color[METER_NORMAL_COLOR], 0, 60000, 0);
  set_color (&color[METER_WARNING_COLOR], 50000, 55000, 0);
  set_color (&color[METER_OVER_COLOR], 60000, 0, 0);
  set_color (&color[METER_PEAK_COLOR], 0, 0, 60000);
}
