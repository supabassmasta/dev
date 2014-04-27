#include <stdint.h>

#ifndef IBNIZ_H
#define IBNIZ_H

#ifdef IBNIZ_MAIN
#  define GLOBAL
#else
#  define GLOBAL extern
#endif

#include "vm.h"

/* i/o stuff used by vm */

#ifdef __cplusplus
extern "C" {
#endif


uint32_t gettimevalue();
int getuserchar(vm_t * vm_p);
void waitfortimechange();

/* vm-specific */

void vm_compile(char*src, vm_t * vm_p);
void vm_init(vm_t * vm_p);
//int vm_run();
int32_t vm_run(int32_t in, vm_t * vm_p);
void switchmediacontext(vm_t * vm_p);


/*
// Ju: not useful for chugin

GLOBAL char*clipboard;
void clipboard_load();
void clipboard_store();


#if defined(WIN32)
#define  CLIPBOARD_WIN32
#elif defined(X11)
#define  CLIPBOARD_X11
 #include <SDL/SDL.h>
 void clipboard_handlesysreq(SDL_Event*e);
#else
#define  CLIPBOARD_NONE
#endif

*/

#ifdef __cplusplus
}
#endif

#endif
