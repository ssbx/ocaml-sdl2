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

#include <SDL_hints.h>
#include "hintPriority_stub.h"


CAMLprim value
caml_SDL_SetHintWithPriority(value hint, value valstr, value priority)
{
    CAMLparam3(hint, valstr, priority);

    int r = SDL_SetHintWithPriority(
                String_val(hint),
                String_val(valstr),
                Sdl_hintpriority_t(priority));
    if (r) caml_failwith("sdlhint.set_with_prio");
    CAMLreturn(Val_unit);
}

CAMLprim value
caml_SDL_SetHint(value hint, value valstr)
{
    CAMLparam2(hint, valstr);

    int _was_set = SDL_SetHint(
                    String_val(hint),
                    String_val(valstr));

    /* CAMLreturn(Bool_val(was_set)); */
    CAMLreturn(Val_unit);
}

CAMLprim value
caml_SDL_GetHint(value hint)
{
    CAMLparam1(hint);
    CAMLlocal2(val,ret);

    const char *hint_val = SDL_GetHint(String_val(hint));

    if (hint_val) {
        val = caml_copy_string(hint_val);
        ret = caml_alloc_some(val);
    } else {
        ret = Val_none;
    }
    CAMLreturn(ret);
}



/*
CAMLprim value
caml_SDL_GetTicks_d(value unit)
{
    CAMLparam1(unit);
    CAMLlocal1(ret);
    static const Uint32 th = 1000;
    Uint32 ticks = SDL_GetTicks();
    Uint32 sec = ticks / th;
    Uint32 msec = ticks - sec * th;
    ret = caml_alloc(2, 0);
    Store_field(ret, 0, Val_int(sec));
    Store_field(ret, 1, Val_int(msec));
    CAMLreturn(ret);
}

CAMLprim value
caml_SDL_Delay(value ms)
{
    CAMLparam1(ms);
    SDL_Delay(Long_val(ms));
    CAMLreturn(Val_unit);
}
*/
/* vim: set ts=4 sw=4 et: */
