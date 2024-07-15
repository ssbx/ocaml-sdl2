open Blendmode
open Pixel
open Video
open Rect
open Surface

module Renderer = struct type t end

module RendererInfo = struct
  type t = {
    name: string;
    max_texture_width: int;
    max_texture_height: int;
  }
end

module RendererFlags = struct
  type t =
    | Software
    | Accelerated
    | PresentVSync
    | TargetTexture

  let to_string = function
    | Software        -> "Software"
    | Accelerated     -> "Accelerated"
    | PresentVSync    -> "PresentVSync"
    | TargetTexture   -> "TargetTexture"

  let of_string s =
    match String.lowercase_ascii s with
    | "software"      -> Software
    | "accelerated"   -> Accelerated
    | "presentvsync"  -> PresentVSync
    | "targettexture" -> TargetTexture
    | _ -> invalid_arg "Sdl.RendererFlags.of_string"
end

module RendererFlip = struct
  type t =
    | Flip_None
    | Flip_Horizontal
    | Flip_Vertical
end

module TextureAccess = struct
  type t = Static | Streaming | Target

  let to_string = function
    | Static    -> "SDL_TEXTUREACCESS_STATIC"
    | Streaming -> "SDL_TEXTUREACCESS_STREAMING"
    | Target    -> "SDL_TEXTUREACCESS_TARGET"

  let of_string s =
    match String.uppercase_ascii s with
    | "SDL_TEXTUREACCESS_STATIC"    -> Static
    | "SDL_TEXTUREACCESS_STREAMING" -> Streaming
    | "SDL_TEXTUREACCESS_TARGET"    -> Target
    | _ -> invalid_arg "SdltextureAccess.of_string"
end

module Texture = struct type t end

external create_window_and_renderer :
  width:int -> height:int ->
  flags:WindowFlags.t list ->
  Window.t * Renderer.t
  = "caml_SDL_CreateWindowAndRenderer"

external create_renderer :
  win:Window.t -> index:int ->
  flags:RendererFlags.t list -> Renderer.t
  = "caml_SDL_CreateRenderer"

external render_set_logical_size : Renderer.t -> int * int -> unit
  = "caml_SDL_RenderSetLogicalSize"

external render_set_logical_size2 : Renderer.t -> width:int -> height:int -> unit
  = "caml_SDL_RenderSetLogicalSize2"

external render_set_viewport :
  Renderer.t -> Rect.t -> unit
  = "caml_SDL_RenderSetViewport"

external render_set_clip_rect :
  Renderer.t -> Rect.t -> unit
  = "caml_SDL_RenderSetClipRect"

external set_render_draw_color :
  Renderer.t -> rgb:(int * int * int) -> a:int -> unit
  = "caml_SDL_SetRenderDrawColor"

external set_render_draw_color3 :
  Renderer.t -> r:int -> g:int -> b:int -> a:int -> unit
  = "caml_SDL_SetRenderDrawColor3"

external set_render_draw_blend_mode : Renderer.t -> BlendMode.t -> unit
  = "caml_SDL_SetRenderDrawBlendMode"

external render_draw_point :
  Renderer.t -> int * int -> unit
  = "caml_SDL_RenderDrawPoint"

external render_draw_point2 :
  Renderer.t -> x:int -> y:int -> unit
  = "caml_SDL_RenderDrawPoint2"

external render_draw_points :
  Renderer.t -> points:(int * int) array -> unit
  = "caml_SDL_RenderDrawPoints"

external render_draw_line :
  Renderer.t -> ((int * int) * (int * int)) -> unit
  = "caml_SDL_RenderDrawLine"

external render_draw_line2 :
  Renderer.t -> p1:(int * int) -> p2:(int * int) -> unit
  = "caml_SDL_RenderDrawLine2"

external render_draw_lines :
  Renderer.t -> (int * int) array -> unit
  = "caml_SDL_RenderDrawLines"

external render_draw_rect :
  Renderer.t -> Rect.t -> unit
  = "caml_SDL_RenderDrawRect"

external render_draw_rects :
  Renderer.t -> Rect.t array -> unit
  = "caml_SDL_RenderDrawRects"

external render_fill_rect :
  Renderer.t -> Rect.t -> unit
  = "caml_SDL_RenderFillRect"

external render_fill_rects :
  Renderer.t -> Rect.t array -> unit
  = "caml_SDL_RenderFillRects"

external render_copy : Renderer.t ->
  texture:Texture.t ->
  ?src_rect:Rect.t ->
  ?dst_rect:Rect.t -> unit -> unit
  = "caml_SDL_RenderCopy"

external render_copyEx : Renderer.t ->
  texture:Texture.t ->
  ?src_rect:Rect.t ->
  ?dst_rect:Rect.t ->
  ?angle:float ->
  ?center:int * int ->
  ?flip:RendererFlip.t ->
  unit -> unit
  = "caml_SDL_RenderCopyEx_bc"
    "caml_SDL_RenderCopyEx"

external render_set_scale : Renderer.t -> float * float -> unit
  = "caml_SDL_RenderSetScale"

external render_present : Renderer.t -> unit
  = "caml_SDL_RenderPresent"

external render_clear : Renderer.t -> unit
  = "caml_SDL_RenderClear"

external get_num_render_drivers : unit -> int
  = "caml_SDL_GetNumRenderDrivers"

external get_render_driver_info : int -> RendererInfo.t
  = "caml_SDL_GetRenderDriverInfo"

external render_read_pixels : Renderer.t -> ?rect:Rect.t -> Surface.t -> unit
  = "caml_SDL_RenderReadPixels"

external render_create_texture :
    Renderer.t ->
    PixelFormat.t ->
    TextureAccess.t ->
    int -> int ->
    Texture.t
  = "caml_SDL_CreateTexture"

external destroy_texture : Texture.t -> unit
  = "caml_SDL_DestroyTexture"

external set_renderer_target :
    Renderer.t ->
    Texture.t option -> unit
  = "caml_SDL_SetRenderTarget"

external get_renderer_output_size : Renderer.t -> int * int
  = "caml_SDL_GetRendererOutputSize"

external create_texture_from_surface :
  Renderer.t -> Surface.t -> Texture.t
  = "caml_SDL_CreateTextureFromSurface"

external set_texture_blend_mode : Texture.t -> BlendMode.t -> unit
  = "caml_SDL_SetTextureBlendMode" [@@noalloc]

external get_texture_blend_mode : Texture.t -> BlendMode.t
  = "caml_SDL_GetTextureBlendMode"

external set_texture_alpha_mod : Texture.t -> alpha:int -> unit
  = "caml_SDL_SetTextureAlphaMod"

external get_texture_alpha_mod : Texture.t -> int
  = "caml_SDL_GetTextureAlphaMod"

external set_texture_color_mod : Texture.t -> int * int * int -> unit
  = "caml_SDL_SetTextureColorMod"

external set_texture_color_mod3 : Texture.t -> r:int -> g:int -> b:int -> unit
  = "caml_SDL_SetTextureColorMod3"

external get_texture_color_mod : Texture.t -> int * int * int
  = "caml_SDL_GetTextureColorMod"

