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
#include <caml/version.h>

#include <SDL_rwops.h>

#include "camlsdl2/rwops_stub.h"

#if OCAML_VERSION < 40600
#define Bytes_val(x) String_val(x)
#endif

CAMLprim value
caml_SDL_RWFromMem(value str)
{
    CAMLparam1(str);
    SDL_RWops * rwo =
        SDL_RWFromMem(
                Bytes_val(str),
                caml_string_length(str));
    CAMLreturn(Val_SDL_RWops(rwo));
}

CAMLprim value
caml_SDL_RWFromConstMem(value str)
{
    CAMLparam1(str);
    SDL_RWops * rwo =
        SDL_RWFromConstMem(
                String_val(str),
                caml_string_length(str));
    CAMLreturn(Val_SDL_RWops(rwo));
}

CAMLprim value
caml_SDL_RWFromFile(value file, value mode)
{
    CAMLparam2(file, mode);
    SDL_RWops * rwo =
        SDL_RWFromFile(
                String_val(file),
                String_val(mode));
    if (rwo == NULL) caml_failwith("Sdlrwops.from_file");
    CAMLreturn(Val_SDL_RWops(rwo));
}

CAMLprim value
caml_SDL_AllocRW(value unit)
{
    CAMLparam1(unit);
    SDL_RWops * rwo = SDL_AllocRW();
    CAMLreturn(Val_SDL_RWops(rwo));
}

CAMLprim value
caml_SDL_FreeRW(value rwo)
{
    CAMLparam1(rwo);
    SDL_FreeRW(SDL_RWops_val(rwo));
    CAMLreturn(Val_unit);
}

CAMLprim value
caml_SDL_CloseRW(value rwo)
{
    CAMLparam1(rwo);
    SDL_RWclose(SDL_RWops_val(rwo));
    CAMLreturn(Val_unit);
}

CAMLprim value
caml_SDL_RWsize(value rwo)
{
    CAMLparam1(rwo);
    Sint64 size = SDL_RWsize(SDL_RWops_val(rwo));
    CAMLreturn(caml_copy_int64(size));
}

static const int ocaml_SDL_RW_SEEK_table[] = {
    RW_SEEK_SET,
    RW_SEEK_CUR,
    RW_SEEK_END,
};
#define SDL_RW_SEEK_val(seek) \
    ocaml_SDL_RW_SEEK_table[Long_val(seek)]

CAMLprim value
caml_SDL_RWseek(value context, value offset, value whence)
{
    CAMLparam3(context, offset, whence);
    // returns the final offset in the data stream, or -1 on error.
    Sint64 r =
        SDL_RWseek(
                SDL_RWops_val(context),
                Int64_val(offset),
                SDL_RW_SEEK_val(whence));

    CAMLreturn(caml_copy_int64(r));
}

CAMLprim value
caml_SDL_RWtell(value context)
{
    CAMLparam1(context);
    // returns the current offset in the data stream, or -1 on error.
    Sint64 r = SDL_RWtell(SDL_RWops_val(context));
    CAMLreturn(caml_copy_int64(r));
}

#define Uint8_val(d) (Int_val(d))
#define Val_Uint8(d) (Val_int(d))

#define Uint16_val(d) (Int_val(d))
#define Val_Uint16(d) (Val_int(d))

#define Uint32_val(d) (Int32_val(d))
#define Val_Uint32(d) (caml_copy_int32(d))

#define Uint64_val(d) (Int64_val(d))
#define Val_Uint64(d) (caml_copy_int64(d))


#define read_int_stub(IntT, SDL_ReadT) \
  CAMLprim value \
  caml_##SDL_ReadT(value rwo) { \
      IntT d = SDL_ReadT(SDL_RWops_val(rwo)); \
      return Val_##IntT(d); \
  }

read_int_stub(Uint8, SDL_ReadU8)

read_int_stub(Uint16, SDL_ReadLE16)
read_int_stub(Uint16, SDL_ReadBE16)
read_int_stub(Uint32, SDL_ReadLE32)
read_int_stub(Uint32, SDL_ReadBE32)
read_int_stub(Uint64, SDL_ReadLE64)
read_int_stub(Uint64, SDL_ReadBE64)


#if 0
CAMLprim value
caml_SDL_WriteU8(value rwo, Uint8 d)
{
    CAMLparam2(rwo, d);
    // Returns 1 on successful write, 0 on error.
    size_t s = SDL_WriteU8(SDL_RWops_val(rwo), Uint8_val(d));
    if (s == 0) caml_failwith("Sdlrwops.writeU8");
    CAMLreturn(Val_unit);
}
#endif

#define write_int_stub(IntT, SDL_WriteT, ml_writeT) \
  CAMLprim value \
  caml_##SDL_WriteT(value rwo, value d) { \
      size_t s = \
          SDL_WriteT(SDL_RWops_val(rwo), IntT##_val(d)); \
      if (s == 0) caml_failwith("Sdlrwops." ml_writeT); \
      return Val_unit; \
  }

write_int_stub(Uint8, SDL_WriteU8, "writeU8")

write_int_stub(Uint16, SDL_WriteLE16, "LittleEndian.write16")
write_int_stub(Uint16, SDL_WriteBE16, "BigEndian.write16")
write_int_stub(Uint32, SDL_WriteLE32, "LittleEndian.write32")
write_int_stub(Uint32, SDL_WriteBE32, "BigEndian.write32")
write_int_stub(Uint64, SDL_WriteLE64, "LittleEndian.write64")
write_int_stub(Uint64, SDL_WriteBE64, "BigEndian.write64")

/* vim: set ts=4 sw=4 et: */


