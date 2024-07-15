(* OCamlSDL2 - An OCaml interface to the SDL2 library
 Copyright (C) 2013 Florent Monnier

 This software is provided "AS-IS", without any express or implied warranty.
 In no event will the authors be held liable for any damages arising from
 the use of this software.

 Permission is granted to anyone to use this software for any purpose,
 including commercial applications, and to alter it and redistribute it freely.
*)
(* Read / Write operations *)

type rwops_t

external rw_from_mem : bytes -> rwops_t
  = "caml_SDL_RWFromMem"

external rw_from_const_mem : string -> rwops_t
  = "caml_SDL_RWFromConstMem"

external rw_from_file : filename:string -> mode:string -> rwops_t
  = "caml_SDL_RWFromFile"

type input = [
  | `Filename of string  (* provide the input by its filename *)
  | `Buffer of bytes     (* provide the input data as a bytes buffer *)
  | `String of string    (* provide the input data as a string buffer *)
  ]

let from_input = function
  | `Filename(filename) -> rw_from_file ~filename ~mode:"r"
  | `Buffer(mem) -> rw_from_mem mem
  | `String(mem) -> rw_from_const_mem mem

let from_input_opt = function
  | `Filename(filename) -> Some(rw_from_file ~filename ~mode:"r")
  | `Buffer(mem) -> Some(rw_from_mem mem)
  | `String(mem) -> Some(rw_from_const_mem mem)
  | _ -> None

external alloc_rw : unit -> rwops_t = "caml_SDL_AllocRW"
external free_rw : rwops_t -> unit = "caml_SDL_FreeRW"

external close_rw : rwops_t -> unit = "caml_SDL_CloseRW"

external rw_size : rwops_t -> int64 = "caml_SDL_RWsize"

type seek =
  | SEEK_SET
  | SEEK_CUR
  | SEEK_END

external rw_seek : rwops_t -> offset:int64 -> seek -> int64
  = "caml_SDL_RWseek"

external rw_tell : rwops_t -> int64
  = "caml_SDL_RWtell"

type uint8 = int

type uint16 = int
type uint32 = int32
type uint64 = int64

external readU8 : rwops_t -> uint8 = "caml_SDL_ReadU8"
external writeU8 : rwops_t -> uint8 -> unit = "caml_SDL_WriteU8"

module BigEndian = struct

  external read16 : rwops_t -> uint16 = "caml_SDL_ReadBE16"
  external read32 : rwops_t -> uint32 = "caml_SDL_ReadBE32"
  external read64 : rwops_t -> uint64 = "caml_SDL_ReadBE64"

  external write16 : rwops_t -> uint16 -> unit = "caml_SDL_WriteBE16"
  external write32 : rwops_t -> uint32 -> unit = "caml_SDL_WriteBE32"
  external write64 : rwops_t -> uint64 -> unit = "caml_SDL_WriteBE64"

end

module LittleEndian = struct

  external read16 : rwops_t -> uint16 = "caml_SDL_ReadLE16"
  external read32 : rwops_t -> uint32 = "caml_SDL_ReadLE32"
  external read64 : rwops_t -> uint64 = "caml_SDL_ReadLE64"

  external write16 : rwops_t -> uint16 -> unit = "caml_SDL_WriteLE16"
  external write32 : rwops_t -> uint32 -> unit = "caml_SDL_WriteLE32"
  external write64 : rwops_t -> uint64 -> unit = "caml_SDL_WriteLE64"

end

