open Blendmode
open Pixel
open Rect

module Surface = struct
  type t
end

module SurfaceBigarray = struct
  type t = Surface.t
end

external create_rgb_surface :
  width:int ->
  height:int ->
  depth:int -> Surface.t
  = "caml_SDL_CreateRGBSurface"

external free_surface : Surface.t -> unit
  = "caml_SDL_FreeSurface"

external load_bmp : filename:string -> Surface.t
  = "caml_SDL_LoadBMP"

external save_bmp : Surface.t -> filename:string -> unit
  = "caml_SDL_SaveBMP"

external fill_rect :
  dst:Surface.t -> rect:Rect.t ->
  color:int32 -> unit
  = "caml_SDL_FillRect"

external blit_surface :
  src:Surface.t -> src_rect:Rect.t ->
  dst:Surface.t -> dst_rect:Rect.t ->
  Rect.t
  = "caml_SDL_BlitSurface"

external blit_surf :
  src:Surface.t -> dst:Surface.t -> dst_rect:Rect.t ->
  Rect.t
  = "caml_SDL_BlitSurf"

external blit_surfs :
  src:Surface.t -> dst:Surface.t -> dst_rect:Rect.t -> unit
  = "caml_SDL_BlitSurfs"

external surface_blit_pixels_unsafe :
  Surface.t -> string -> unit
  = "caml_SDL_Surface_Blit_Pixels"

external set_color_key : Surface.t -> enable:bool -> key:int32 -> unit
  = "caml_SDL_SetColorKey"

external set_color_key_map_rgb : Surface.t -> enable:bool ->
  rgb:(int * int * int) -> unit
  = "caml_SDL_SetColorKey_MapRGB"

external get_surface_width : Surface.t -> int
  = "caml_SDL_SurfaceGetWidth"

external get_surface_height : Surface.t -> int
  = "caml_SDL_SurfaceGetHeight"

external get_surface_dims : Surface.t -> int * int
  = "caml_SDL_SurfaceGetDims"

external get_surface_pitch : Surface.t -> int
  = "caml_SDL_SurfaceGetPitch"

external get_surface_pixel32_unsafe : Surface.t -> x:int -> y:int -> int32
  = "caml_SDL_SurfaceGetPixel32"

external get_surface_pixel16_unsafe : Surface.t -> x:int -> y:int -> int32
  = "caml_SDL_SurfaceGetPixel16"

external get_surface_pixel8_unsafe : Surface.t -> x:int -> y:int -> int32
  = "caml_SDL_SurfaceGetPixel8"

external get_surface_bits_per_pixel : Surface.t -> int
  = "caml_SDL_SurfaceGetBitsPerPixel"

external surface_has_palette : Surface.t -> bool
  = "caml_SDL_SurfaceHasPalette"

external surface_palette_colors : Surface.t -> int
  = "caml_SDL_SurfacePaletteColors"

external set_surface_blend_mode : Surface.t -> BlendMode.t -> unit
  = "caml_SDL_SetSurfaceBlendMode"

external surface_get_pixelformat_t : Surface.t -> PixelFormat.t
  = "caml_SDL_Surface_get_pixelformat_t"

external surface_get_pixels : Surface.t -> string
  = "caml_SDL_Surface_get_pixels"


external surface_ba_get_pixels :
  SurfaceBigarray.t -> (int, Bigarray.int8_unsigned_elt, Bigarray.c_layout) Bigarray.Array1.t
  = "caml_SDL_Surface_ba_get_pixels"

external create_rgb_surface_from :
  pixels:(int, Bigarray.int8_unsigned_elt, Bigarray.c_layout) Bigarray.Array1.t ->
  width:int -> height:int -> depth:int -> pitch:int ->
  r_mask:int32 ->
  g_mask:int32 ->
  b_mask:int32 ->
  a_mask:int32 -> SurfaceBigarray.t
  = "caml_SDL_CreateRGBSurfaceFrom_bytecode"
    "caml_SDL_CreateRGBSurfaceFrom"

