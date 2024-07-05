#ifndef _CAML_SDL_HINTPRIORITY_
#define _CAML_SDL_HINTPRIORITY_

#include <SDL_hints.h>

value Val_Sdl_hintpriority_t(int texture_access);

extern const int caml_sdl_hintpriority_table[];
#define Sdl_hintpriority_t(v) \
    caml_sdl_hintpriority_table[Int_val(v)]

#endif /* _CAML_SDL_HINTPRIORITY_ */
