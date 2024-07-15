open Blendmode
open Pixel
open Video
type renderer_t = Render_type.renderer_t

external create_window_and_renderer :
  width:int -> height:int ->
  flags:WindowFlags.t list ->
  Window.t * renderer_t
  = "caml_SDL_CreateWindowAndRenderer"

type renderer_flags_t =
  | Software
  | Accelerated
  | PresentVSync
  | TargetTexture

let string_of_renderer_flags = function
  | Software        -> "Software"
  | Accelerated     -> "Accelerated"
  | PresentVSync    -> "PresentVSync"
  | TargetTexture   -> "TargetTexture"

let renderer_flags_of_string s =
  match String.lowercase_ascii s with
  | "software"      -> Software
  | "accelerated"   -> Accelerated
  | "presentvsync"  -> PresentVSync
  | "targettexture" -> TargetTexture
  | _ -> invalid_arg "Render.renderer_flags_of_string"

external create_renderer :
  win:Window.t -> index:int ->
  flags:renderer_flags_t list -> renderer_t
  = "caml_SDL_CreateRenderer"

external render_set_logical_size : renderer_t -> int * int -> unit
  = "caml_SDL_RenderSetLogicalSize"

external render_set_logical_size2 : renderer_t -> width:int -> height:int -> unit
  = "caml_SDL_RenderSetLogicalSize2"

external render_set_viewport :
  renderer_t -> Rect.rect_t -> unit
  = "caml_SDL_RenderSetViewport"

external render_set_clip_rect :
  renderer_t -> Rect.rect_t -> unit
  = "caml_SDL_RenderSetClipRect"

external set_render_draw_color :
  renderer_t -> rgb:(int * int * int) -> a:int -> unit
  = "caml_SDL_SetRenderDrawColor"

external set_render_draw_color3 :
  renderer_t -> r:int -> g:int -> b:int -> a:int -> unit
  = "caml_SDL_SetRenderDrawColor3"

external set_render_draw_blend_mode : renderer_t -> BlendMode.t -> unit
  = "caml_SDL_SetRenderDrawBlendMode"

external render_draw_point :
  renderer_t -> int * int -> unit
  = "caml_SDL_RenderDrawPoint"

external render_draw_point2 :
  renderer_t -> x:int -> y:int -> unit
  = "caml_SDL_RenderDrawPoint2"

external render_draw_points :
  renderer_t -> points:(int * int) array -> unit
  = "caml_SDL_RenderDrawPoints"

external render_draw_line :
  renderer_t -> ((int * int) * (int * int)) -> unit
  = "caml_SDL_RenderDrawLine"

external render_draw_line2 :
  renderer_t -> p1:(int * int) -> p2:(int * int) -> unit
  = "caml_SDL_RenderDrawLine2"

external render_draw_lines :
  renderer_t -> (int * int) array -> unit
  = "caml_SDL_RenderDrawLines"

external render_draw_rect :
  renderer_t -> Rect.rect_t -> unit
  = "caml_SDL_RenderDrawRect"

external render_draw_rects :
  renderer_t -> Rect.rect_t array -> unit
  = "caml_SDL_RenderDrawRects"

external render_fill_rect :
  renderer_t -> Rect.rect_t -> unit
  = "caml_SDL_RenderFillRect"

external render_fill_rects :
  renderer_t -> Rect.rect_t array -> unit
  = "caml_SDL_RenderFillRects"

external render_copy : renderer_t ->
  texture:Texture.texture_t ->
  ?src_rect:Rect.rect_t ->
  ?dst_rect:Rect.rect_t -> unit -> unit
  = "caml_SDL_RenderCopy"

type renderer_flip_t =
  | Flip_None
  | Flip_Horizontal
  | Flip_Vertical

external render_copyEx : renderer_t ->
  texture:Texture.texture_t ->
  ?src_rect:Rect.rect_t ->
  ?dst_rect:Rect.rect_t ->
  ?angle:float ->
  ?center:int * int ->
  ?flip:renderer_flip_t ->
  unit -> unit
  = "caml_SDL_RenderCopyEx_bc"
    "caml_SDL_RenderCopyEx"

external render_set_scale : renderer_t -> float * float -> unit
  = "caml_SDL_RenderSetScale"

external render_present : renderer_t -> unit
  = "caml_SDL_RenderPresent"

external render_clear : renderer_t -> unit
  = "caml_SDL_RenderClear"

type renderer_info = {
  name: string;
  max_texture_width: int;
  max_texture_height: int;
}

external get_render_drivers : unit -> renderer_info array
  = "caml_SDL_GetRenderDrivers"

external render_read_pixels : renderer_t -> ?rect:Rect.rect_t -> Surface.surface_t -> unit
  = "caml_SDL_RenderReadPixels"

external render_create_texture : renderer_t -> PixelFormat.t -> TextureAccess.texture_access_t -> int -> int -> Texture.texture_t = "caml_SDL_CreateTexture"

external destroy_texture : Texture.texture_t -> unit = "caml_SDL_DestroyTexture"

external set_renderer_target : renderer_t -> Texture.texture_t option -> unit = "caml_SDL_SetRenderTarget"
external get_renderer_output_size : renderer_t -> int * int = "caml_SDL_GetRendererOutputSize"

