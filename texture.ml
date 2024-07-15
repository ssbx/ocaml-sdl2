(* OCamlSDL2 - An OCaml interface to the SDL2 library
 Copyright (C) 2013 Florent Monnier

 This software is provided "AS-IS", without any express or implied warranty.
 In no event will the authors be held liable for any damages arising from
 the use of this software.

 Permission is granted to anyone to use this software for any purpose,
 including commercial applications, and to alter it and redistribute it freely.
*)
(* Textures *)

open Blendmode
type texture_t

external create_texture_from_surface :
  Render_type.renderer_t -> Surface.surface_t -> texture_t
  = "caml_SDL_CreateTextureFromSurface"

external set_texture_blend_mode : texture_t -> BlendMode.t -> unit
  = "caml_SDL_SetTextureBlendMode" [@@noalloc]

external get_texture_blend_mode : texture_t -> BlendMode.t
  = "caml_SDL_GetTextureBlendMode"

external set_texture_alpha_mod : texture_t -> alpha:int -> unit
  = "caml_SDL_SetTextureAlphaMod"

external get_texture_alpha_mod : texture_t -> int
  = "caml_SDL_GetTextureAlphaMod"

external set_texture_color_mod : texture_t -> int * int * int -> unit
  = "caml_SDL_SetTextureColorMod"

external set_texture_color_mod3 : texture_t -> r:int -> g:int -> b:int -> unit
  = "caml_SDL_SetTextureColorMod3"

external get_texture_color_mod : texture_t -> int * int * int
  = "caml_SDL_GetTextureColorMod"

