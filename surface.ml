type surface_t
open Blendmode
open Pixel

external create_rgb_surface :
  width:int ->
  height:int ->
  depth:int -> surface_t
  = "caml_SDL_CreateRGBSurface"

external free_surface : surface_t -> unit
  = "caml_SDL_FreeSurface"

external load_bmp : filename:string -> surface_t
  = "caml_SDL_LoadBMP"

external save_bmp : surface_t -> filename:string -> unit
  = "caml_SDL_SaveBMP"

external fill_rect :
  dst:surface_t -> rect:Rect.rect_t ->
  color:int32 -> unit
  = "caml_SDL_FillRect"

external blit_surface :
  src:surface_t -> src_rect:Rect.rect_t ->
  dst:surface_t -> dst_rect:Rect.rect_t ->
  Rect.rect_t
  = "caml_SDL_BlitSurface"

external blit_surf :
  src:surface_t -> dst:surface_t -> dst_rect:Rect.rect_t ->
  Rect.rect_t
  = "caml_SDL_BlitSurf"

external blit_surfs :
  src:surface_t -> dst:surface_t -> dst_rect:Rect.rect_t -> unit
  = "caml_SDL_BlitSurfs"

external surface_blit_pixels_unsafe :
  surface_t -> string -> unit
  = "caml_SDL_Surface_Blit_Pixels"

external set_color_key : surface_t -> enable:bool -> key:int32 -> unit
  = "caml_SDL_SetColorKey"

external set_color_key_map_rgb : surface_t -> enable:bool ->
  rgb:(int * int * int) -> unit
  = "caml_SDL_SetColorKey_MapRGB"

external get_surface_width : surface_t -> int = "caml_SDL_SurfaceGetWidth"
external get_surface_height : surface_t -> int = "caml_SDL_SurfaceGetHeight"

external get_surface_dims : surface_t -> int * int = "caml_SDL_SurfaceGetDims"

external get_surface_pitch : surface_t -> int = "caml_SDL_SurfaceGetPitch"

external get_surface_pixel32_unsafe : surface_t -> x:int -> y:int -> int32
  = "caml_SDL_SurfaceGetPixel32"

external get_surface_pixel16_unsafe : surface_t -> x:int -> y:int -> int32
  = "caml_SDL_SurfaceGetPixel16"

external get_surface_pixel8_unsafe : surface_t -> x:int -> y:int -> int32
  = "caml_SDL_SurfaceGetPixel8"

external get_surface_bits_per_pixel : surface_t -> int
  = "caml_SDL_SurfaceGetBitsPerPixel"

external surface_has_palette : surface_t -> bool
  = "caml_SDL_SurfaceHasPalette"

external surface_palette_colors : surface_t -> int
  = "caml_SDL_SurfacePaletteColors"

external set_surface_blend_mode : surface_t -> BlendMode.t -> unit
  = "caml_SDL_SetSurfaceBlendMode"

external surface_get_pixelformat_t : surface_t -> PixelFormat.t
  = "caml_SDL_Surface_get_pixelformat_t"

external surface_get_pixels : surface_t -> string
  = "caml_SDL_Surface_get_pixels"

