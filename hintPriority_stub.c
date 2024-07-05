/* OCamlSDL2 - An OCaml interface to the SDL2 library
 Copyright (C) 2013 Florent Monnier

 This software is provided "AS-IS", without any express or implied warranty.
 In no event will the authors be held liable for any damages arising from
 the use of this software.

 Permission is granted to anyone to use this software for any purpose,
 including commercial applications, and to alter it and redistribute it freely.
*/
#define CAML_NAME_SPACE
#include <caml/mlvalues.h>
#include <caml/memory.h>
#include <caml/alloc.h>
#include <caml/fail.h>

#include <SDL.h>
#include <SDL_hints.h>

const Uint32 caml_sdl_hintpriority_table[] = {
    SDL_HINT_DEFAULT,
    SDL_HINT_NORMAL,
    SDL_HINT_OVERRIDE
};

value
Val_Sdl_hintpriority_t(int hint_priority)
{
    switch (hint_priority) {
    case SDL_HINT_DEFAULT:    return Val_int(0);
    case SDL_HINT_NORMAL: return Val_int(1);
    case SDL_HINT_OVERRIDE:    return Val_int(2);
    }
    caml_failwith("Sdl_hintprority.t");
}

/* vim: set ts=4 sw=4 et: */
