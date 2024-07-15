(* OCamlSDL2 - An OCaml interface to the SDL2 library
 Copyright (C) 2013 Florent Monnier

 This software is provided "AS-IS", without any express or implied warranty.
 In no event will the authors be held liable for any damages arising from
 the use of this software.

 Permission is granted to anyone to use this software for any purpose,
 including commercial applications, and to alter it and redistribute it freely.
*)
(* Read / Write operations *)


module RWops = struct
  type t

  type uint8 = int
  type uint16 = int
  type uint32 = int32
  type uint64 = int64

  type input = [
    | `Filename of string  (* provide the input by its filename *)
    | `Buffer of bytes     (* provide the input data as a bytes buffer *)
    | `String of string    (* provide the input data as a string buffer *)
  ]

  type seek =
    | SEEK_SET
    | SEEK_CUR
    | SEEK_END
end

external rw_from_mem : bytes -> RWops.t
  = "caml_SDL_RWFromMem"

external rw_from_const_mem : string -> RWops.t
  = "caml_SDL_RWFromConstMem"

external rw_from_file : filename:string -> mode:string -> RWops.t
  = "caml_SDL_RWFromFile"

external alloc_rw : unit -> RWops.t
  = "caml_SDL_AllocRW"

external free_rw : RWops.t -> unit
  = "caml_SDL_FreeRW"

external close_rw : RWops.t -> unit
  = "caml_SDL_CloseRW"

external rw_size : RWops.t -> int64
  = "caml_SDL_RWsize"

external rw_seek : RWops.t -> offset:int64 -> RWops.seek -> int64
  = "caml_SDL_RWseek"

external rw_tell : RWops.t -> int64
  = "caml_SDL_RWtell"

external read_U8 : RWops.t -> RWops.uint8
  = "caml_SDL_ReadU8"

external write_U8 : RWops.t -> RWops.uint8 -> unit
  = "caml_SDL_WriteU8"

external read_be16 : RWops.t -> RWops.uint16
  = "caml_SDL_ReadBE16"

external read_be32 : RWops.t -> RWops.uint32
  = "caml_SDL_ReadBE32"

external read_be64 : RWops.t -> RWops.uint64
  = "caml_SDL_ReadBE64"

external write_be16 : RWops.t -> RWops.uint16 -> unit
  = "caml_SDL_WriteBE16"

external write_be32 : RWops.t -> RWops.uint32 -> unit
  = "caml_SDL_WriteBE32"

external write_be64 : RWops.t -> RWops.uint64 -> unit
  = "caml_SDL_WriteBE64"

external read_le16 : RWops.t -> RWops.uint16
  = "caml_SDL_ReadLE16"

external read_le32 : RWops.t -> RWops.uint32
  = "caml_SDL_ReadLE32"

external read_le64 : RWops.t -> RWops.uint64
  = "caml_SDL_ReadLE64"

external write_le16 : RWops.t -> RWops.uint16 -> unit
  = "caml_SDL_WriteLE16"

external write_le32 : RWops.t -> RWops.uint32 -> unit
  = "caml_SDL_WriteLE32"

external write_le64 : RWops.t -> RWops.uint64 -> unit
  = "caml_SDL_WriteLE64"

let from_input = function
  | `Filename(filename) -> rw_from_file ~filename ~mode:"r"
  | `Buffer(mem) -> rw_from_mem mem
  | `String(mem) -> rw_from_const_mem mem

let from_input_opt = function
  | `Filename(filename) -> Some(rw_from_file ~filename ~mode:"r")
  | `Buffer(mem) -> Some(rw_from_mem mem)
  | `String(mem) -> Some(rw_from_const_mem mem)
  | _ -> None

