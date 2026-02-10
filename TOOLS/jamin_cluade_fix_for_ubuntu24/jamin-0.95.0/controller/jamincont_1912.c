#include <stdlib.h>
#include <string.h>
#ifndef WIN32
#include "config.h"
#endif

#ifdef ENABLE_NLS
#include <libintl.h>
#endif

#define         _ISOC9X_SOURCE  1
#define         _ISOC99_SOURCE  1
#define         __USE_ISOC99    1
#define         __USE_ISOC9X    1

#include <math.h>

#include "ladspa.h"

#ifdef WIN32
#define _WINDOWS_DLL_EXPORT_ __declspec(dllexport)
int bIsFirstTime = 1; 
void _init(); // forward declaration
#else
#define _WINDOWS_DLL_EXPORT_ 
#endif

#line 10 "jamincont_1912.xml"

#include <unistd.h>
#include <stdio.h>
#include <pthread.h>
#include <lo/lo.h>

#include "../src/constants.h"

#define EXITV -999

//#define DEBUG 1

static int scene = -1;
static int thread_created = 0;
static pthread_t thread;

static void *controller_thread(void *p)
{
  int last_scene = -1;
        lo_address address = lo_address_new(NULL, OSC_PORT);

  printf("THREAD\n");

  while (scene != EXITV) {
#ifdef DEBUG
printf(". %d\n", scene);
#endif
    if (last_scene != scene) {
      last_scene = scene;
      if (last_scene > 0 && last_scene <= NUM_SCENES) {
        lo_send(address, SCENE_URI, "i", last_scene);
      }
    }
#ifdef DEBUG
    usleep(1000000);
#else
    usleep(10000);
#endif
  }

  lo_address_free(address);
#ifdef DEBUG
printf("DONE\n");
#endif

  return NULL;
}

#define JAMINCONTROLLER_SCENE_CONT     0
#define JAMINCONTROLLER_INPUT          1
#define JAMINCONTROLLER_OUTPUT         2

static LADSPA_Descriptor *jaminControllerDescriptor = NULL;

typedef struct {
	LADSPA_Data *scene_cont;
	LADSPA_Data *input;
	LADSPA_Data *output;
	LADSPA_Data run_adding_gain;
} JaminController;

_WINDOWS_DLL_EXPORT_
const LADSPA_Descriptor *ladspa_descriptor(unsigned long index) {

#ifdef WIN32
	if (bIsFirstTime) {
		_init();
		bIsFirstTime = 0;
	}
#endif
	switch (index) {
	case 0:
		return jaminControllerDescriptor;
	default:
		return NULL;
	}
}

static void activateJaminController(LADSPA_Handle instance) {
	JaminController *plugin_data = (JaminController *)instance;
#line 75 "jamincont_1912.xml"
	#ifdef DEBUG
	printf("activate called\n");
	#endif
	      scene = -1;

}

static void cleanupJaminController(LADSPA_Handle instance) {
#line 94 "jamincont_1912.xml"
	JaminController *plugin_data = (JaminController *)instance;
	#ifdef DEBUG
	printf("cleanup called\n");
	#endif
	      scene = EXITV;
	      thread_created = 0;
	      //pthread_cancel(thread);
	free(instance);
}

static void connectPortJaminController(
 LADSPA_Handle instance,
 unsigned long port,
 LADSPA_Data *data) {
	JaminController *plugin;

	plugin = (JaminController *)instance;
	switch (port) {
	case JAMINCONTROLLER_SCENE_CONT:
		plugin->scene_cont = data;
		break;
	case JAMINCONTROLLER_INPUT:
		plugin->input = data;
		break;
	case JAMINCONTROLLER_OUTPUT:
		plugin->output = data;
		break;
	}
}

static LADSPA_Handle instantiateJaminController(
 const LADSPA_Descriptor *descriptor,
 unsigned long s_rate) {
	JaminController *plugin_data = (JaminController *)malloc(sizeof(JaminController));

#line 64 "jamincont_1912.xml"
	#ifdef DEBUG
	printf("instantiate called\n");
	#endif
	      scene = -1;
	      if (!thread_created) {
	        thread_created = 1;
	        pthread_create(&thread, NULL, controller_thread, NULL);
	      }


	return (LADSPA_Handle)plugin_data;
}

#undef buffer_write
#undef RUN_ADDING
#undef RUN_REPLACING

#define buffer_write(b, v) (b = v)
#define RUN_ADDING    0
#define RUN_REPLACING 1

static void runJaminController(LADSPA_Handle instance, unsigned long sample_count) {
	JaminController *plugin_data = (JaminController *)instance;

	/* Scene no. (float value) */
	const LADSPA_Data scene_cont = *(plugin_data->scene_cont);

	/* Input (array of floats of length sample_count) */
	const LADSPA_Data * const input = plugin_data->input;

	/* Output (array of floats of length sample_count) */
	LADSPA_Data * const output = plugin_data->output;

#line 82 "jamincont_1912.xml"
	unsigned long pos;

	scene = (int)(scene_cont + 0.5f);

	if (input != output) {
	  for (pos = 0; pos < sample_count; pos++) {
	    buffer_write(output[pos], input[pos]);
	  }
	}
}
#undef buffer_write
#undef RUN_ADDING
#undef RUN_REPLACING

#define buffer_write(b, v) (b += (v) * run_adding_gain)
#define RUN_ADDING    1
#define RUN_REPLACING 0

static void setRunAddingGainJaminController(LADSPA_Handle instance, LADSPA_Data gain) {
	((JaminController *)instance)->run_adding_gain = gain;
}

static void runAddingJaminController(LADSPA_Handle instance, unsigned long sample_count) {
	JaminController *plugin_data = (JaminController *)instance;
	LADSPA_Data run_adding_gain = plugin_data->run_adding_gain;

	/* Scene no. (float value) */
	const LADSPA_Data scene_cont = *(plugin_data->scene_cont);

	/* Input (array of floats of length sample_count) */
	const LADSPA_Data * const input = plugin_data->input;

	/* Output (array of floats of length sample_count) */
	LADSPA_Data * const output = plugin_data->output;

#line 82 "jamincont_1912.xml"
	unsigned long pos;

	scene = (int)(scene_cont + 0.5f);

	if (input != output) {
	  for (pos = 0; pos < sample_count; pos++) {
	    buffer_write(output[pos], input[pos]);
	  }
	}
}

void _init() {
	char **port_names;
	LADSPA_PortDescriptor *port_descriptors;
	LADSPA_PortRangeHint *port_range_hints;

#define D_(s) (s)


	jaminControllerDescriptor =
	 (LADSPA_Descriptor *)malloc(sizeof(LADSPA_Descriptor));

	if (jaminControllerDescriptor) {
		jaminControllerDescriptor->UniqueID = 1912;
		jaminControllerDescriptor->Label = "jaminController";
		jaminControllerDescriptor->Properties =
		 LADSPA_PROPERTY_HARD_RT_CAPABLE;
		jaminControllerDescriptor->Name =
		 D_("JAMin Controller");
		jaminControllerDescriptor->Maker =
		 "xxx <yyy@zzz.com>";
		jaminControllerDescriptor->Copyright =
		 "GPL";
		jaminControllerDescriptor->PortCount = 3;

		port_descriptors = (LADSPA_PortDescriptor *)calloc(3,
		 sizeof(LADSPA_PortDescriptor));
		jaminControllerDescriptor->PortDescriptors =
		 (const LADSPA_PortDescriptor *)port_descriptors;

		port_range_hints = (LADSPA_PortRangeHint *)calloc(3,
		 sizeof(LADSPA_PortRangeHint));
		jaminControllerDescriptor->PortRangeHints =
		 (const LADSPA_PortRangeHint *)port_range_hints;

		port_names = (char **)calloc(3, sizeof(char*));
		jaminControllerDescriptor->PortNames =
		 (const char **)port_names;

		/* Parameters for Scene no. */
		port_descriptors[JAMINCONTROLLER_SCENE_CONT] =
		 LADSPA_PORT_INPUT | LADSPA_PORT_CONTROL;
		port_names[JAMINCONTROLLER_SCENE_CONT] =
		 D_("Scene no.");
		port_range_hints[JAMINCONTROLLER_SCENE_CONT].HintDescriptor =
		 LADSPA_HINT_BOUNDED_BELOW | LADSPA_HINT_BOUNDED_ABOVE | LADSPA_HINT_DEFAULT_1 | LADSPA_HINT_INTEGER;
		port_range_hints[JAMINCONTROLLER_SCENE_CONT].LowerBound = 1;
		port_range_hints[JAMINCONTROLLER_SCENE_CONT].UpperBound = NUM_SCENES;

		/* Parameters for Input */
		port_descriptors[JAMINCONTROLLER_INPUT] =
		 LADSPA_PORT_INPUT | LADSPA_PORT_AUDIO;
		port_names[JAMINCONTROLLER_INPUT] =
		 D_("Input");
		port_range_hints[JAMINCONTROLLER_INPUT].HintDescriptor = 0;

		/* Parameters for Output */
		port_descriptors[JAMINCONTROLLER_OUTPUT] =
		 LADSPA_PORT_OUTPUT | LADSPA_PORT_AUDIO;
		port_names[JAMINCONTROLLER_OUTPUT] =
		 D_("Output");
		port_range_hints[JAMINCONTROLLER_OUTPUT].HintDescriptor = 0;

		jaminControllerDescriptor->activate = activateJaminController;
		jaminControllerDescriptor->cleanup = cleanupJaminController;
		jaminControllerDescriptor->connect_port = connectPortJaminController;
		jaminControllerDescriptor->deactivate = NULL;
		jaminControllerDescriptor->instantiate = instantiateJaminController;
		jaminControllerDescriptor->run = runJaminController;
		jaminControllerDescriptor->run_adding = runAddingJaminController;
		jaminControllerDescriptor->set_run_adding_gain = setRunAddingGainJaminController;
	}
}

void _fini() {
	if (jaminControllerDescriptor) {
		free((LADSPA_PortDescriptor *)jaminControllerDescriptor->PortDescriptors);
		free((char **)jaminControllerDescriptor->PortNames);
		free((LADSPA_PortRangeHint *)jaminControllerDescriptor->PortRangeHints);
		free(jaminControllerDescriptor);
	}

}
