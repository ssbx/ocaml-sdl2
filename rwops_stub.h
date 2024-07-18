#ifndef _CAML_SDL_RWOPS_
#define _CAML_SDL_RWOPS_

#include <SDL_rwops.h>

static value Val_SDL_RWops(SDL_RWops * p)
{
    return caml_copy_nativeint((intnat) p);
}

static SDL_RWops * SDL_RWops_val(value v)
{
    return (SDL_RWops *) Nativeint_val(v);
}

#endif /* _CAML_SDL_RWOPS_ */
