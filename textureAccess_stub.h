#ifndef _CAML_SDL_TEXTUREACCESS_
#define _CAML_SDL_TEXTUREACCESS_

#include <SDL_render.h>

value Val_Sdl_textureaccess_t(int texture_access);

extern const int caml_sdl_textureaccess_table[];
#define Sdl_textureaccess_t(v) \
    caml_sdl_textureaccess_table[Int_val(v)]

#endif /* _CAML_SDL_TEXTUREACCESS_ */
