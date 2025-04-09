(** Ocaml binding to libsdl2. API follow the original libsdl2 ones. API is presented following the SDL category listing ({:https://wiki.libsdl.org/SDL2/APIByCategory}). *)

type uint8 = int
type uint16 = int
type uint32 = int32
type uint64 = int64

(** {1:base Basics} *)

(** {2:init Initialization and Shutdown} *)

module Subsystem : sig
  type t =
    [ `AUDIO
    | `EVENTS
    | `EVERYTHING
    | `GAMECONTROLLER
    | `HAPTIC
    | `JOYSTICK
    | `NOPARACHUTE
    | `TIMER
    | `VIDEO
    ]
end

external init : Subsystem.t list -> unit = "caml_SDL_Init"
external init_subsystem : Subsystem.t list -> unit = "caml_SDL_InitSubSystem"
external quit : unit -> unit = "caml_SDL_Quit"
external quit_requested : unit -> bool = "caml_SDL_QuitRequested"

(** {2:hint Configuration Variables} *)

module HintPriority : sig
  type t =
    | Default
    | Normal
    | Override

  val to_string : t -> string
  val of_string : string -> t
end

external get_hint : string -> string option = "caml_SDL_GetHint"
external set_hint : string -> string -> unit = "caml_SDL_SetHint"

external set_hint_with_priority
  :  string
  -> string
  -> HintPriority.t
  -> unit
  = "caml_SDL_SetHintWithPriority"

(** {2:err Error Handling} *)

external get_error : unit -> string = "caml_SDL_GetError"
external set_error : string -> unit = "caml_SDL_SetError"
external clear_error : unit -> unit = "caml_SDL_ClearError"

(** {2:ver Querying SDL Version} *)

module Version : sig
  type t =
    { major : int
    ; minor : int
    ; patch : int
    }
end

external get_runtime_version : unit -> Version.t = "caml_SDL_GetRunTimeVersion"
external get_compiled_version : unit -> Version.t = "caml_SDL_GetCompiledVersion"
external get_revision : unit -> string = "caml_SDL_GetRevision"

(** {1:au Audio} *)

(** {2:audio Audio Device Management, Playing and Recording} *)

module AudioBuffer : sig
  type t
end

module AudioDeviceID : sig
  type t
end

module AudioSpec : sig
  type t
end

module AudioStream : sig
  type t
end

module AudioFormat : sig
  type t =
    | AUDIO_U8
    | AUDIO_S8
    | AUDIO_U16LSB
    | AUDIO_S16LSB
    | AUDIO_U16MSB
    | AUDIO_S16MSB
    | AUDIO_U16
    | AUDIO_S16
    | AUDIO_S32LSB
    | AUDIO_S32MSB
    | AUDIO_S32
    | AUDIO_F32LSB
    | AUDIO_F32MSB
    | AUDIO_F32
    | AUDIO_U16SYS
    | AUDIO_S16SYS
    | AUDIO_S32SYS
    | AUDIO_F32SYS
end

module AudioStatus : sig
  type t =
    | Stopped
    | Playing
    | Paused

  val to_string : t -> string
  val of_string : string -> t
end

external new_audio_spec : unit -> AudioSpec.t = "caml_SDL_alloc_audio_spec"
external free_audio_spec : AudioSpec.t -> unit = "caml_SDL_free_audio_spec"
external get_audio_drivers : unit -> string array = "caml_SDL_GetAudioDrivers"
external audio_init : driver_name:string -> unit = "caml_SDL_AudioInit"
external audio_quit : unit -> unit = "caml_SDL_AudioQuit"
external get_current_audio_driver : unit -> string = "caml_SDL_GetCurrentAudioDriver"
external get_audio_status : unit -> AudioStatus.t = "caml_SDL_GetAudioStatus"
external pause_audio : pause_on:bool -> unit = "caml_SDL_PauseAudio"
external lock_audio : unit -> unit = "caml_SDL_LockAudio"
external unlock_audio : unit -> unit = "caml_SDL_UnlockAudio"
external close_audio : unit -> unit = "caml_SDL_CloseAudio"

external load_wav
  :  filename:string
  -> spec:AudioSpec.t
  -> AudioBuffer.t * int32
  = "caml_SDL_LoadWAV"

external free_wav : AudioBuffer.t -> unit = "caml_SDL_FreeWAV"

external open_audio_device_simple
  :  AudioSpec.t
  -> AudioDeviceID.t
  = "caml_SDL_OpenAudioDevice_simple"

external queue_audio
  :  AudioDeviceID.t
  -> AudioBuffer.t
  -> int32
  -> unit
  = "caml_SDL_QueueAudio"

external unpause_audio_device : AudioDeviceID.t -> unit = "caml_SDL_UnpauseAudioDevice"
external pause_audio_device : AudioDeviceID.t -> unit = "caml_SDL_PauseAudioDevice"
external close_audio_device : AudioDeviceID.t -> unit = "caml_SDL_CloseAudioDevice"

(** {1:v Video} *)

(** {2:rect Rectangle Functions} *)

module Rect : sig
  type t =
    { x : int
    ; y : int
    ; w : int
    ; h : int
    }

  val make : x:int -> y:int -> w:int -> h:int -> t
end

module Point : sig
  type t =
    { x : int
    ; y : int
    }
end

external has_intersection : a:Rect.t -> b:Rect.t -> bool = "caml_SDL_HasIntersection"

external intersect_rect_and_line
  :  rect:Rect.t
  -> x1:int
  -> y1:int
  -> x2:int
  -> y2:int
  -> (int * int * int * int) option
  = "caml_SDL_IntersectRectAndLine"

external point_in_rect : p:Point.t -> r:Rect.t -> bool = "caml_SDL_PointInRect"

(** {2:pixel Pixel Formats and Conversion Routines} *)

module Color : sig
  type t =
    { r : uint8
    ; g : uint8
    ; b : uint8
    ; a : uint8
    }

  val make : r:uint8 -> g:uint8 -> b:uint8 -> a:uint8 -> t
end

module PixelFormat : sig
  type t =
    | Unknown
    | Index1LSB
    | Index1MSB
    | Index4LSB
    | Index4MSB
    | Index8
    | RGB332
    | RGB444
    | RGB555
    | BGR555
    | ARGB4444
    | RGBA4444
    | ABGR4444
    | BGRA4444
    | ARGB1555
    | RGBA5551
    | ABGR1555
    | BGRA5551
    | RGB565
    | BGR565
    | RGB24
    | BGR24
    | RGB888
    | RGBX8888
    | BGR888
    | BGRX8888
    | ARGB8888
    | RGBA8888
    | ABGR8888
    | BGRA8888
    | ARGB2101010
    | YV12
    | IYUV
    | YUY2
    | UYVY
    | YVYU

  val to_string : t -> string
  val of_string : string -> t

  type allocated
end

external get_pixel_format_name : PixelFormat.t -> string = "caml_SDL_GetPixelFormatName"
external alloc_format : PixelFormat.t -> PixelFormat.allocated = "caml_SDL_AllocFormat"
external free_format : PixelFormat.allocated -> unit = "caml_SDL_FreeFormat"

type rgb = uint8 * uint8 * uint8
type rgba = uint8 * uint8 * uint8 * uint8

external map_RGB : PixelFormat.allocated -> rgb:rgb -> int32 = "caml_SDL_MapRGB"
external map_RGBA : PixelFormat.allocated -> rgba:rgba -> int32 = "caml_SDL_MapRGBA"
external get_RGB : pixel:int32 -> fmt:PixelFormat.allocated -> rgb = "caml_SDL_GetRGB"
external get_RGBA : pixel:int32 -> fmt:PixelFormat.allocated -> rgba = "caml_SDL_GetRGBA"

(** {2:bl SDL_blendmode.h} *)

module BlendMode : sig
  type t =
    | NONE
    | BLEND
    | ADD
    | MOD
    | MUL

  val to_string : t -> string
  val of_string : string -> t
end

(** {2:surf Surface Creation and Simple Drawing} *)

module Surface : sig
  type t
end

module SurfaceBigarray : sig
  type t = Surface.t
end

external create_rgb_surface
  :  width:int
  -> height:int
  -> depth:int
  -> Surface.t
  = "caml_SDL_CreateRGBSurface"

external free_surface : Surface.t -> unit = "caml_SDL_FreeSurface"
external load_bmp : filename:string -> Surface.t = "caml_SDL_LoadBMP"
external save_bmp : Surface.t -> filename:string -> unit = "caml_SDL_SaveBMP"

external fill_rect
  :  dst:Surface.t
  -> rect:Rect.t
  -> color:int32
  -> unit
  = "caml_SDL_FillRect"

external blit_surface
  :  src:Surface.t
  -> src_rect:Rect.t
  -> dst:Surface.t
  -> dst_rect:Rect.t
  -> Rect.t
  = "caml_SDL_BlitSurface"

external blit_surf
  :  src:Surface.t
  -> dst:Surface.t
  -> dst_rect:Rect.t
  -> Rect.t
  = "caml_SDL_BlitSurf"

external blit_surfs
  :  src:Surface.t
  -> dst:Surface.t
  -> dst_rect:Rect.t
  -> unit
  = "caml_SDL_BlitSurfs"

external surface_blit_pixels_unsafe
  :  Surface.t
  -> string
  -> unit
  = "caml_SDL_Surface_Blit_Pixels"

external set_color_key
  :  Surface.t
  -> enable:bool
  -> key:int32
  -> unit
  = "caml_SDL_SetColorKey"

external set_color_key_map_rgb
  :  Surface.t
  -> enable:bool
  -> rgb:int * int * int
  -> unit
  = "caml_SDL_SetColorKey_MapRGB"

external get_surface_width : Surface.t -> int = "caml_SDL_SurfaceGetWidth"
external get_surface_height : Surface.t -> int = "caml_SDL_SurfaceGetHeight"
external get_surface_dims : Surface.t -> int * int = "caml_SDL_SurfaceGetDims"
external get_surface_pitch : Surface.t -> int = "caml_SDL_SurfaceGetPitch"

external get_surface_pixel32_unsafe
  :  Surface.t
  -> x:int
  -> y:int
  -> int32
  = "caml_SDL_SurfaceGetPixel32"

external get_surface_pixel16_unsafe
  :  Surface.t
  -> x:int
  -> y:int
  -> int32
  = "caml_SDL_SurfaceGetPixel16"

external get_surface_pixel8_unsafe
  :  Surface.t
  -> x:int
  -> y:int
  -> int32
  = "caml_SDL_SurfaceGetPixel8"

external get_surface_bits_per_pixel : Surface.t -> int = "caml_SDL_SurfaceGetBitsPerPixel"
external surface_has_palette : Surface.t -> bool = "caml_SDL_SurfaceHasPalette"
external surface_palette_colors : Surface.t -> int = "caml_SDL_SurfacePaletteColors"

external set_surface_blend_mode
  :  Surface.t
  -> BlendMode.t
  -> unit
  = "caml_SDL_SetSurfaceBlendMode"

external surface_get_pixelformat_t
  :  Surface.t
  -> PixelFormat.t
  = "caml_SDL_Surface_get_pixelformat_t"

external surface_get_pixels : Surface.t -> string = "caml_SDL_Surface_get_pixels"

external surface_ba_get_pixels
  :  SurfaceBigarray.t
  -> (int, Bigarray.int8_unsigned_elt, Bigarray.c_layout) Bigarray.Array1.t
  = "caml_SDL_Surface_ba_get_pixels"

external create_rgb_surface_from
  :  pixels:(int, Bigarray.int8_unsigned_elt, Bigarray.c_layout) Bigarray.Array1.t
  -> width:int
  -> height:int
  -> depth:int
  -> pitch:int
  -> r_mask:int32
  -> g_mask:int32
  -> b_mask:int32
  -> a_mask:int32
  -> SurfaceBigarray.t
  = "caml_SDL_CreateRGBSurfaceFrom_bytecode" "caml_SDL_CreateRGBSurfaceFrom"

(** {2:dsp Display and Window Management} *)

module Window : sig
  type t
end

module WindowFlags : sig
  type t =
    | FullScreen
    | OpenGL
    | Shown
    | Hidden
    | Borderless
    | Resizable
    | Minimized
    | Maximized
    | Input_Grabbed
    | Input_Focus
    | Mouse_Focus
    | FullScreen_Desktop
    | Foreign
    | Allow_HighDPI
end

module WindowPos : sig
  type t =
    [ `centered
    | `pos of int
    | `undefined
    ]
end

module WindowEventID : sig
  type t =
    | NONE
    | SHOWN
    | HIDDEN
    | EXPOSED
    | MOVED of Point.t
    | RESIZED of Point.t
    | SIZE_CHANGED of Point.t
    | MINIMIZED
    | MAXIMIZED
    | RESTORED
    | ENTER
    | LEAVE
    | FOCUS_GAINED
    | FOCUS_LOST
    | CLOSE
    | TAKE_FOCUS
    | HIT_TEST

  val string_of_id : t -> string
end

module GLattr : sig
  type t =
    | SDL_GL_RED_SIZE
    | SDL_GL_GREEN_SIZE
    | SDL_GL_BLUE_SIZE
    | SDL_GL_ALPHA_SIZE
    | SDL_GL_BUFFER_SIZE
    | SDL_GL_DOUBLEBUFFER
    | SDL_GL_DEPTH_SIZE
    | SDL_GL_STENCIL_SIZE
    | SDL_GL_ACCUM_RED_SIZE
    | SDL_GL_ACCUM_GREEN_SIZE
    | SDL_GL_ACCUM_BLUE_SIZE
    | SDL_GL_ACCUM_ALPHA_SIZE
    | SDL_GL_STEREO
    | SDL_GL_MULTISAMPLEBUFFERS
    | SDL_GL_MULTISAMPLESAMPLES
    | SDL_GL_ACCELERATED_VISUAL
    | SDL_GL_RETAINED_BACKING
    | SDL_GL_CONTEXT_MAJOR_VERSION
    | SDL_GL_CONTEXT_MINOR_VERSION
    | SDL_GL_CONTEXT_EGL
    | SDL_GL_CONTEXT_FLAGS
    | SDL_GL_CONTEXT_PROFILE_MASK
    | SDL_GL_SHARE_WITH_CURRENT_CONTEXT
end

module GLcontext : sig
  type t
end

external gl_create_context : win:Window.t -> GLcontext.t = "caml_SDL_GL_CreateContext"

external gl_make_current
  :  win:Window.t
  -> ctx:GLcontext.t
  -> int
  = "caml_SDL_GL_MakeCurrent"

external gl_unload_library : unit -> unit = "caml_SDL_GL_UnloadLibrary"

external gl_extension_supported
  :  extension:string
  -> bool
  = "caml_SDL_GL_ExtensionSupported"

external gl_set_swap_interval : interval:int -> unit = "caml_SDL_GL_SetSwapInterval"
external gl_get_swap_interval : unit -> int = "caml_SDL_GL_GetSwapInterval"
external gl_swap_window : Window.t -> unit = "caml_SDL_GL_SwapWindow"
external gl_delete_context : GLcontext.t -> unit = "caml_SDL_GL_DeleteContext"
external set_attribute : GLattr.t -> int -> unit = "caml_SDL_GL_SetAttribute"
external get_attribute : GLattr.t -> int = "caml_SDL_GL_GetAttribute"

external create_window
  :  title:string
  -> x:WindowPos.t
  -> y:WindowPos.t
  -> width:int
  -> height:int
  -> flags:WindowFlags.t list
  -> Window.t
  = "caml_SDL_CreateWindow_bc" "caml_SDL_CreateWindow"

external set_window_title
  :  window:Window.t
  -> title:string
  -> unit
  = "caml_SDL_SetWindowTitle"

external show_window : Window.t -> unit = "caml_SDL_ShowWindow"
external hide_window : Window.t -> unit = "caml_SDL_HideWindow"
external raise_window : Window.t -> unit = "caml_SDL_RaiseWindow"
external maximize_window : Window.t -> unit = "caml_SDL_MaximizeWindow"
external minimize_window : Window.t -> unit = "caml_SDL_MinimizeWindow"
external restore_window : Window.t -> unit = "caml_SDL_RestoreWindow"
external get_window_surface : Window.t -> Surface.t = "caml_SDL_GetWindowSurface"
external update_window_surface : Window.t -> unit = "caml_SDL_UpdateWindowSurface"

external set_window_brightness
  :  Window.t
  -> brightness:float
  -> unit
  = "caml_SDL_SetWindowBrightness"

external get_window_brightness : Window.t -> float = "caml_SDL_GetWindowBrightness"
external destroy_window : Window.t -> unit = "caml_SDL_DestroyWindow"
external get_window_size : Window.t -> int * int = "caml_SDL_GetWindowSize"

(** {2:rend 2D Accelerated Rendering} *)

module Renderer : sig
  type t
end

module RendererInfo : sig
  type t =
    { name : string
    ; max_texture_width : int
    ; max_texture_height : int
    }
end

module RendererFlags : sig
  type t =
    | Software
    | Accelerated
    | PresentVSync
    | TargetTexture

  val to_string : t -> string
  val of_string : string -> t
end

module RendererFlip : sig
  type t =
    | Flip_None
    | Flip_Horizontal
    | Flip_Vertical
end

module TextureAccess : sig
  type t =
    | Static
    | Streaming
    | Target

  val to_string : t -> string
  val of_string : string -> t
end

module Texture : sig
  type t
end

external create_window_and_renderer
  :  width:int
  -> height:int
  -> flags:WindowFlags.t list
  -> Window.t * Renderer.t
  = "caml_SDL_CreateWindowAndRenderer"

external create_renderer
  :  win:Window.t
  -> index:int
  -> flags:RendererFlags.t list
  -> Renderer.t
  = "caml_SDL_CreateRenderer"

external destroy_renderer : Renderer.t -> unit = "caml_SDL_DestroyRenderer"

external render_set_logical_size
  :  Renderer.t
  -> width:int
  -> height:int
  -> unit
  = "caml_SDL_RenderSetLogicalSize"

external render_set_viewport : Renderer.t -> Rect.t -> unit = "caml_SDL_RenderSetViewport"

external render_set_clip_rect
  :  Renderer.t
  -> Rect.t
  -> unit
  = "caml_SDL_RenderSetClipRect"

external set_render_draw_color
  :  Renderer.t
  -> r:int
  -> g:int
  -> b:int
  -> a:int
  -> unit
  = "caml_SDL_SetRenderDrawColor"

external set_render_draw_blend_mode
  :  Renderer.t
  -> BlendMode.t
  -> unit
  = "caml_SDL_SetRenderDrawBlendMode"

external render_draw_point : Renderer.t -> int * int -> unit = "caml_SDL_RenderDrawPoint"

external render_draw_point2
  :  Renderer.t
  -> x:int
  -> y:int
  -> unit
  = "caml_SDL_RenderDrawPoint2"

external render_draw_points
  :  Renderer.t
  -> points:(int * int) array
  -> unit
  = "caml_SDL_RenderDrawPoints"

external render_draw_line
  :  Renderer.t
  -> (int * int) * (int * int)
  -> unit
  = "caml_SDL_RenderDrawLine"

external render_draw_line2
  :  Renderer.t
  -> p1:int * int
  -> p2:int * int
  -> unit
  = "caml_SDL_RenderDrawLine2"

external render_draw_lines
  :  Renderer.t
  -> (int * int) array
  -> unit
  = "caml_SDL_RenderDrawLines"

external render_draw_rect : Renderer.t -> Rect.t -> unit = "caml_SDL_RenderDrawRect"

external render_draw_rects
  :  Renderer.t
  -> Rect.t array
  -> unit
  = "caml_SDL_RenderDrawRects"

external render_fill_rect : Renderer.t -> Rect.t -> unit = "caml_SDL_RenderFillRect"

external render_fill_rects
  :  Renderer.t
  -> Rect.t array
  -> unit
  = "caml_SDL_RenderFillRects"

external render_copy
  :  Renderer.t
  -> texture:Texture.t
  -> srcrect:Rect.t option
  -> dstrect:Rect.t option
  -> unit
  = "caml_SDL_RenderCopy"

external render_copyEx
  :  Renderer.t
  -> texture:Texture.t
  -> srcrect:Rect.t option
  -> dstrect:Rect.t option
  -> angle:float
  -> center:Point.t option
  -> flip:RendererFlip.t
  -> unit
  = "caml_SDL_RenderCopyEx_bc" "caml_SDL_RenderCopyEx"

external render_set_scale
  :  Renderer.t
  -> scaleX:float
  -> scaleY:float
  -> unit
  = "caml_SDL_RenderSetScale"

external render_present : Renderer.t -> unit = "caml_SDL_RenderPresent"
external render_clear : Renderer.t -> unit = "caml_SDL_RenderClear"
external get_num_render_drivers : unit -> int = "caml_SDL_GetNumRenderDrivers"
external get_render_driver_info : int -> RendererInfo.t = "caml_SDL_GetRenderDriverInfo"

external render_read_pixels
  :  Renderer.t
  -> ?rect:Rect.t
  -> Surface.t
  -> unit
  = "caml_SDL_RenderReadPixels"

external create_texture
  :  Renderer.t
  -> fmt:PixelFormat.t
  -> access:TextureAccess.t
  -> width:int
  -> height:int
  -> Texture.t
  = "caml_SDL_CreateTexture"

external destroy_texture : Texture.t -> unit = "caml_SDL_DestroyTexture"

external query_texture
  :  Texture.t
  -> PixelFormat.t * TextureAccess.t * int * int
  = "caml_SDL_QueryTexture"

external set_render_target
  :  Renderer.t
  -> Texture.t option
  -> unit
  = "caml_SDL_SetRenderTarget"

external get_renderer_output_size
  :  Renderer.t
  -> int * int
  = "caml_SDL_GetRendererOutputSize"

external create_texture_from_surface
  :  Renderer.t
  -> Surface.t
  -> Texture.t
  = "caml_SDL_CreateTextureFromSurface"

external set_texture_blend_mode
  :  Texture.t
  -> BlendMode.t
  -> unit
  = "caml_SDL_SetTextureBlendMode"
[@@noalloc]

external get_texture_blend_mode
  :  Texture.t
  -> BlendMode.t
  = "caml_SDL_GetTextureBlendMode"

external set_texture_alpha_mod
  :  Texture.t
  -> alpha:int
  -> unit
  = "caml_SDL_SetTextureAlphaMod"

external get_texture_alpha_mod : Texture.t -> int = "caml_SDL_GetTextureAlphaMod"

external set_texture_color_mod
  :  Texture.t
  -> int * int * int
  -> unit
  = "caml_SDL_SetTextureColorMod"

external set_texture_color_mod3
  :  Texture.t
  -> r:int
  -> g:int
  -> b:int
  -> unit
  = "caml_SDL_SetTextureColorMod3"

external get_texture_color_mod
  :  Texture.t
  -> int * int * int
  = "caml_SDL_GetTextureColorMod"

(** {2:clip Clipboard Handling} *)

external set_clipboard_text : text:string -> int = "caml_SDL_SetClipboardText"
external get_clipboard_text : unit -> string = "caml_SDL_GetClipboardText"
external has_clipboard_text : unit -> bool = "caml_SDL_HasClipboardText"

(** {1:info Platform and CPU Information} *)

(** {2:pla Platform Detection} *)

external get_platform : unit -> string = "caml_SDL_GetPlatform"

(** {2:cpu CPU Feature Detection} *)

external get_CPU_count : unit -> int = "caml_SDL_GetCPUCount"

(** {1:feedback Force Feedback} *)

(** {2:hap Force Feedback Support} *)

module HapticPosition : sig
  type t =
    { left : bool
    ; right : bool
    ; up : bool
    ; down : bool
    }

  val string_of_pos : t -> string
end

module HapticDirection : sig
  type t =
    | Centered
    | Up
    | Right
    | Down
    | Left
    | Right_Up
    | Right_Down
    | Left_Up
    | Left_Down

  val string_of_dir : t -> string
  val dir_of_string : string -> t
end

(** {1:pow Power Management} *)

(** {2:powman Power Management Status} *)

module PowerState : sig
  type t =
    [ `Charged
    | `Charging
    | `No_Battery
    | `On_Battery
    | `Unknown
    ]
end

external get_power_info : unit -> PowerState.t * int * int = "caml_SDL_GetPowerInfo"

(** {1:tm Timers} *)

(** {2:ti Timer Support} *)

external get_ticks : unit -> int = "caml_SDL_GetTicks" [@@noalloc]
external delay : ms:int -> unit = "caml_SDL_Delay"

(** {1:fs File Abstraction} *)

(** {2:paths Filesystem Paths} *)

external get_base_path : unit -> string = "caml_SDL_GetBasePath"
external get_pref_path : org:string -> app:string -> string = "caml_SDL_GetPrefPath"

(** {2:rwo File I/O Abstraction} *)

module RWops : sig
  type t

  type input =
    [ `Buffer of bytes
    | `Filename of string
    | `String of string
    ]

  type seek =
    | SEEK_SET
    | SEEK_CUR
    | SEEK_END
end

external rw_from_mem : bytes -> RWops.t = "caml_SDL_RWFromMem"
external rw_from_const_mem : string -> RWops.t = "caml_SDL_RWFromConstMem"
external rw_from_file : filename:string -> mode:string -> RWops.t = "caml_SDL_RWFromFile"
external alloc_rw : unit -> RWops.t = "caml_SDL_AllocRW"
external free_rw : RWops.t -> unit = "caml_SDL_FreeRW"
external close_rw : RWops.t -> unit = "caml_SDL_CloseRW"
external rw_size : RWops.t -> int64 = "caml_SDL_RWsize"
external rw_seek : RWops.t -> offset:int64 -> RWops.seek -> int64 = "caml_SDL_RWseek"
external rw_tell : RWops.t -> int64 = "caml_SDL_RWtell"
external read_U8 : RWops.t -> uint8 = "caml_SDL_ReadU8"
external write_U8 : RWops.t -> uint8 -> unit = "caml_SDL_WriteU8"
external read_be16 : RWops.t -> uint16 = "caml_SDL_ReadBE16"
external read_be32 : RWops.t -> uint32 = "caml_SDL_ReadBE32"
external read_be64 : RWops.t -> uint64 = "caml_SDL_ReadBE64"
external write_be16 : RWops.t -> uint16 -> unit = "caml_SDL_WriteBE16"
external write_be32 : RWops.t -> uint32 -> unit = "caml_SDL_WriteBE32"
external write_be64 : RWops.t -> uint64 -> unit = "caml_SDL_WriteBE64"
external read_le16 : RWops.t -> uint16 = "caml_SDL_ReadLE16"
external read_le32 : RWops.t -> uint32 = "caml_SDL_ReadLE32"
external read_le64 : RWops.t -> uint64 = "caml_SDL_ReadLE64"
external write_le16 : RWops.t -> uint16 -> unit = "caml_SDL_WriteLE16"
external write_le32 : RWops.t -> uint32 -> unit = "caml_SDL_WriteLE32"
external write_le64 : RWops.t -> uint64 -> unit = "caml_SDL_WriteLE64"

val from_input
  :  [< `Buffer of bytes | `Filename of string | `String of string ]
  -> RWops.t

val from_input_opt
  :  [> `Buffer of bytes | `Filename of string | `String of string ]
  -> RWops.t option

(** {1:evts Input Events} *)

module KeyState : sig
  type t =
    | SDL_RELEASED
    | SDL_PRESSED

  val to_string : t -> string
end

(** {2:joy Joystick Support} *)

module Joystick : sig
  type t
end

external num_joysticks : unit -> int = "caml_SDL_NumJoysticks"

external joystick_name_for_index
  :  device_index:int
  -> string
  = "caml_SDL_JoystickNameForIndex"

external joystick_open : device_index:int -> Joystick.t = "caml_SDL_JoystickOpen"
external joystick_close : Joystick.t -> unit = "caml_SDL_JoystickClose"
external joystick_num_axes : Joystick.t -> int = "caml_SDL_JoystickNumAxes"
external joystick_num_hats : Joystick.t -> int = "caml_SDL_JoystickNumHats"
external joystick_get_axis : Joystick.t -> axis:int -> int = "caml_SDL_JoystickGetAxis"

external joystick_get_button
  :  Joystick.t
  -> button:int
  -> int
  = "caml_SDL_JoystickGetButton"

(** {2:ms Mouse Support} *)

module MouseButton : sig
  type t =
    | Left
    | Middle
    | Right
    | X1
    | X2
    | X3
    | X4
    | X5

  val to_string : t -> string
  val of_string : string -> t
end

module MousePosition : sig
  type t = int * int
end

external get_mouse_state
  :  unit
  -> MousePosition.t * MouseButton.t list
  = "caml_SDL_GetMouseState"

external get_mouse_buttons : unit -> MouseButton.t list = "caml_SDL_GetMouseButtons"
external get_mouse_pos : unit -> MousePosition.t = "caml_SDL_GetMousePos"

external warp_mouse_in_window
  :  Window.t
  -> x:int
  -> y:int
  -> unit
  = "caml_SDL_WarpMouseInWindow"

external set_relative_mouse_mode : enabled:bool -> unit = "caml_SDL_SetRelativeMouseMode"
external show_cursor : toggle:bool -> unit = "caml_SDL_ShowCursor"
external show_cursor_query : unit -> bool = "caml_SDL_ShowCursor_Query"

(** {2:kb Keyboard Support} *)

external start_text_input : unit -> unit = "caml_SDL_StartTextInput"
external stop_text_input : unit -> unit = "caml_SDL_StopTextInput"
external is_text_input_active : unit -> bool = "caml_SDL_IsTextInputActive"
external set_text_input_rect : Rect.t -> unit = "caml_SDL_SetTextInputRect"
external has_screen_keyboard_support : unit -> bool = "caml_SDL_HasScreenKeyboardSupport"

module Keycode : sig
  type t =
    | Unknown
    | Return
    | Escape
    | Backspace
    | Tab
    | Space
    | Exclaim
    | QuoteDBL
    | Hash
    | Percent
    | Dollar
    | Ampersand
    | Quote
    | LeftParen
    | RightParen
    | Asterisk
    | Plus
    | Comma
    | Minus
    | Period
    | Slash
    | Num0
    | Num1
    | Num2
    | Num3
    | Num4
    | Num5
    | Num6
    | Num7
    | Num8
    | Num9
    | Colon
    | SemiColon
    | Less
    | Equals
    | Greater
    | Question
    | At
    | LeftBracket
    | BackSlash
    | RightBracket
    | Caret
    | Underscore
    | BackQuote
    | A
    | B
    | C
    | D
    | E
    | F
    | G
    | H
    | I
    | J
    | K
    | L
    | M
    | N
    | O
    | P
    | Q
    | R
    | S
    | T
    | U
    | V
    | W
    | X
    | Y
    | Z
    | CapsLock
    | F1
    | F2
    | F3
    | F4
    | F5
    | F6
    | F7
    | F8
    | F9
    | F10
    | F11
    | F12
    | PrintScreen
    | ScrollLock
    | Pause
    | Insert
    | Home
    | PageUp
    | Delete
    | End
    | PageDown
    | Right
    | Left
    | Down
    | Up
    | NumLockClear
    | KP_Divide
    | KP_Multiply
    | KP_Minus
    | KP_Plus
    | KP_Enter
    | KP_1
    | KP_2
    | KP_3
    | KP_4
    | KP_5
    | KP_6
    | KP_7
    | KP_8
    | KP_9
    | KP_0
    | KP_Period
    | Application
    | Power
    | KP_Equals
    | F13
    | F14
    | F15
    | F16
    | F17
    | F18
    | F19
    | F20
    | F21
    | F22
    | F23
    | F24
    | Execute
    | Help
    | Menu
    | Select
    | Stop
    | Again
    | Undo
    | Cut
    | Copy
    | Paste
    | Find
    | Mute
    | VolumeUp
    | VolumeDown
    | KP_Comma
    | KP_EqualsAs400
    | ALTERASE
    | SYSREQ
    | CANCEL
    | CLEAR
    | PRIOR
    | RETURN2
    | SEPARATOR
    | OUT
    | OPER
    | CLEARAGAIN
    | CRSEL
    | EXSEL
    | KP_00
    | KP_000
    | ThousandsSeparator
    | DecimalSeparator
    | CurrencyUnit
    | CurrencySubunit
    | KP_LeftParen
    | KP_RightParen
    | KP_LeftBrace
    | KP_RightBrace
    | KP_Tab
    | KP_Backspace
    | KP_A
    | KP_B
    | KP_C
    | KP_D
    | KP_E
    | KP_F
    | KP_Xor
    | KP_Power
    | KP_Percent
    | KP_Less
    | KP_Greater
    | KP_Ampersand
    | KP_DBLAmpersand
    | KP_VerticalBar
    | KP_DBLVerticalBar
    | KP_Colon
    | KP_Hash
    | KP_Space
    | KP_At
    | KP_Exclam
    | KP_MemStore
    | KP_MemRecall
    | KP_MemClear
    | KP_MemAdd
    | KP_MemSubtract
    | KP_MemMultiply
    | KP_MemDivide
    | KP_PlusMinus
    | KP_Clear
    | KP_Clearentry
    | KP_Binary
    | KP_Octal
    | KP_Decimal
    | KP_Hexadecimal
    | LCtrl
    | LShift
    | LAlt
    | LGui
    | RCtrl
    | RShift
    | RAlt
    | RGUI
    | MODE
    | AudioNext
    | AudioPrev
    | AudioStop
    | AudioPlay
    | AudioMute
    | MediaSelect
    | WWW
    | Mail
    | Calculator
    | Computer
    | AC_Search
    | AC_Home
    | AC_Back
    | AC_Forward
    | AC_Stop
    | AC_Refresh
    | AC_Bookmarks
    | BrightnessDown
    | BrightnessUp
    | DisplaySwitch
    | KBDIllumToggle
    | KBDIllumDown
    | KBDIllumUp
    | Eject
    | Sleep

  val to_string : t -> string
  val of_string : string -> t
end

module Keymod : sig
  type t =
    | LShift
    | RShift
    | LCtrl
    | RCtrl
    | LAlt
    | RAlt
    | LGUI
    | RGUI
    | NUM
    | CAPS
    | MODE

  val to_string : t -> string
  val of_string : string -> t
end

module Scancode : sig
  type t =
    | UNKNOWN
    | A
    | B
    | C
    | D
    | E
    | F
    | G
    | H
    | I
    | J
    | K
    | L
    | M
    | N
    | O
    | P
    | Q
    | R
    | S
    | T
    | U
    | V
    | W
    | X
    | Y
    | Z
    | Num1
    | Num2
    | Num3
    | Num4
    | Num5
    | Num6
    | Num7
    | Num8
    | Num9
    | Num0
    | RETURN
    | ESCAPE
    | BACKSPACE
    | TAB
    | SPACE
    | MINUS
    | EQUALS
    | LEFTBRACKET
    | RIGHTBRACKET
    | BACKSLASH
    | NONUSHASH
    | SEMICOLON
    | APOSTROPHE
    | GRAVE
    | COMMA
    | PERIOD
    | SLASH
    | CAPSLOCK
    | F1
    | F2
    | F3
    | F4
    | F5
    | F6
    | F7
    | F8
    | F9
    | F10
    | F11
    | F12
    | PRINTSCREEN
    | SCROLLLOCK
    | PAUSE
    | INSERT
    | HOME
    | PAGEUP
    | DELETE
    | END
    | PAGEDOWN
    | RIGHT
    | LEFT
    | DOWN
    | UP
    | NUMLOCKCLEAR
    | KP_DIVIDE
    | KP_MULTIPLY
    | KP_MINUS
    | KP_PLUS
    | KP_ENTER
    | KP_1
    | KP_2
    | KP_3
    | KP_4
    | KP_5
    | KP_6
    | KP_7
    | KP_8
    | KP_9
    | KP_0
    | KP_PERIOD
    | NONUSBACKSLASH
    | APPLICATION
    | POWER
    | KP_EQUALS
    | F13
    | F14
    | F15
    | F16
    | F17
    | F18
    | F19
    | F20
    | F21
    | F22
    | F23
    | F24
    | EXECUTE
    | HELP
    | MENU
    | SELECT
    | STOP
    | AGAIN
    | UNDO
    | CUT
    | COPY
    | PASTE
    | FIND
    | MUTE
    | VOLUMEUP
    | VOLUMEDOWN
    | KP_COMMA
    | KP_EQUALSAS400
    | INTERNATIONAL1
    | INTERNATIONAL2
    | INTERNATIONAL3
    | INTERNATIONAL4
    | INTERNATIONAL5
    | INTERNATIONAL6
    | INTERNATIONAL7
    | INTERNATIONAL8
    | INTERNATIONAL9
    | LANG1
    | LANG2
    | LANG3
    | LANG4
    | LANG5
    | LANG6
    | LANG7
    | LANG8
    | LANG9
    | ALTERASE
    | SYSREQ
    | CANCEL
    | CLEAR
    | PRIOR
    | RETURN2
    | SEPARATOR
    | OUT
    | OPER
    | CLEARAGAIN
    | CRSEL
    | EXSEL
    | KP_00
    | KP_000
    | THOUSANDSSEPARATOR
    | DECIMALSEPARATOR
    | CURRENCYUNIT
    | CURRENCYSUBUNIT
    | KP_LEFTPAREN
    | KP_RIGHTPAREN
    | KP_LEFTBRACE
    | KP_RIGHTBRACE
    | KP_TAB
    | KP_BACKSPACE
    | KP_A
    | KP_B
    | KP_C
    | KP_D
    | KP_E
    | KP_F
    | KP_XOR
    | KP_POWER
    | KP_PERCENT
    | KP_LESS
    | KP_GREATER
    | KP_AMPERSAND
    | KP_DBLAMPERSAND
    | KP_VERTICALBAR
    | KP_DBLVERTICALBAR
    | KP_COLON
    | KP_HASH
    | KP_SPACE
    | KP_AT
    | KP_EXCLAM
    | KP_MEMSTORE
    | KP_MEMRECALL
    | KP_MEMCLEAR
    | KP_MEMADD
    | KP_MEMSUBTRACT
    | KP_MEMMULTIPLY
    | KP_MEMDIVIDE
    | KP_PLUSMINUS
    | KP_CLEAR
    | KP_CLEARENTRY
    | KP_BINARY
    | KP_OCTAL
    | KP_DECIMAL
    | KP_HEXADECIMAL
    | LCTRL
    | LSHIFT
    | LALT
    | LGUI
    | RCTRL
    | RSHIFT
    | RALT
    | RGUI
    | MODE
    | AUDIONEXT
    | AUDIOPREV
    | AUDIOSTOP
    | AUDIOPLAY
    | AUDIOMUTE
    | MEDIASELECT
    | WWW
    | MAIL
    | CALCULATOR
    | COMPUTER
    | AC_SEARCH
    | AC_HOME
    | AC_BACK
    | AC_FORWARD
    | AC_STOP
    | AC_REFRESH
    | AC_BOOKMARKS
    | BRIGHTNESSDOWN
    | BRIGHTNESSUP
    | DISPLAYSWITCH
    | KBDILLUMTOGGLE
    | KBDILLUMDOWN
    | KBDILLUMUP
    | EJECT
    | SLEEP

  val to_string : t -> string
  val of_string : string -> t
end

(** {2:evtall Event Handling} *)

module KeyboardEvent : sig
  type t =
    { ke_timestamp : int32
    ; ke_window_id : int32
    ; ke_state : KeyState.t
    ; ke_repeat : int
    ; scancode : Scancode.t
    ; keycode : Keycode.t
    ; keymod : Keymod.t list
    }
end

module MouseMotionEvent : sig
  type t =
    { mm_timestamp : int32
    ; mm_window_id : int32
    ; mm_buttons : int list
    ; mm_x : int
    ; mm_y : int
    ; mm_xrel : int
    ; mm_yrel : int
    }
end

module MouseButtonEvent : sig
  type t =
    { mb_timestamp : int32
    ; mb_window_id : int32
    ; mb_button : int
    ; mb_state : KeyState.t
    ; mb_x : int
    ; mb_y : int
    }
end

module MouseWheelEvent : sig
  type t =
    { mw_timestamp : int32
    ; mw_window_id : int32
    ; mw_x : int
    ; mw_y : int
    }
end

module JoyAxisEvent : sig
  type t =
    { ja_timestamp : int32
    ; ja_which : int
    ; ja_axis : int
    ; ja_value : int
    }
end

module JoyButtonEvent : sig
  type t =
    { jb_timestamp : int32
    ; jb_which : int
    ; jb_button : int
    ; jb_state : KeyState.t
    }
end

module JoyHatEvent : sig
  type t =
    { jh_timestamp : int32
    ; jh_which : int
    ; jh_hat : int
    ; jh_dir : HapticDirection.t
    ; jh_pos : HapticPosition.t
    }
end

module JoyDeviceEvent : sig
  type event_type =
    | SDL_JOYDEVICEADDED
    | SDL_JOYDEVICEREMOVED

  val to_string : event_type -> string

  type t =
    { jd_timestamp : int32
    ; jd_which : int
    ; jd_change : event_type
    }
end

module WindowEvent : sig
  type t =
    { we_timestamp : int32
    ; window_ID : int32
    ; kind : WindowEventID.t
    }
end

module QuitEvent : sig
  type t = { quit_timestamp : int32 }
end

module TextEditingEvent : sig
  type t =
    { te_timestamp : int32
    ; te_window_ID : int32
    ; te_text : string
    ; te_begin : int
    ; te_length : int
    }
end

module TextInputEvent : sig
  type t =
    { ti_timestamp : int32
    ; ti_window_ID : int32
    ; ti_text : string
    }
end

module Event : sig
  type t =
    | SDL_QUIT of QuitEvent.t
    | SDL_MOUSEMOTION of MouseMotionEvent.t
    | SDL_MOUSEBUTTONDOWN of MouseButtonEvent.t
    | SDL_MOUSEBUTTONUP of MouseButtonEvent.t
    | SDL_MOUSEWHEEL of MouseWheelEvent.t
    | SDL_KEYDOWN of KeyboardEvent.t
    | SDL_KEYUP of KeyboardEvent.t
    | SDL_TEXTEDITING of TextEditingEvent.t
    | SDL_TEXTINPUT of TextInputEvent.t
    | SDL_JOYAXISMOTION of JoyAxisEvent.t
    | SDL_JOYBALLMOTION
    | SDL_JOYHATMOTION of JoyHatEvent.t
    | SDL_JOYBUTTONDOWN of JoyButtonEvent.t
    | SDL_JOYBUTTONUP of JoyButtonEvent.t
    | SDL_JOYDEVICEADDED of JoyDeviceEvent.t
    | SDL_JOYDEVICEREMOVED of JoyDeviceEvent.t
    | SDL_CONTROLLERAXISMOTION
    | SDL_CONTROLLERBUTTONDOWN
    | SDL_CONTROLLERBUTTONUP
    | SDL_CONTROLLERDEVICEADDED
    | SDL_CONTROLLERDEVICEREMOVED
    | SDL_CONTROLLERDEVICEREMAPPED
    | SDL_FINGERDOWN
    | SDL_FINGERUP
    | SDL_FINGERMOTION
    | SDL_DOLLARGESTURE
    | SDL_DOLLARRECORD
    | SDL_MULTIGESTURE
    | SDL_CLIPBOARDUPDATE
    | SDL_DROPFILE
    | SDL_USEREVENT
    | SDL_WINDOWEVENT of WindowEvent.t
    | SDL_SYSWMEVENT
    | SDL_APP_TERMINATING
    | SDL_APP_LOWMEMORY
    | SDL_APP_WILLENTERBACKGROUND
    | SDL_APP_DIDENTERBACKGROUND
    | SDL_APP_WILLENTERFOREGROUND
    | SDL_APP_DIDENTERFOREGROUND
    | SDL_DISPLAYEVENT
    | SDL_KEYMAPCHANGED
    | SDL_DROPTEXT
    | SDL_DROPBEGIN
    | SDL_DROPCOMPLETE
    | SDL_AUDIODEVICEADDED
    | SDL_AUDIODEVICEREMOVED
    | SDL_SENSORUPDATE
    | SDL_RENDER_TARGETS_RESET
    | SDL_RENDER_DEVICE_RESET

  val to_string : t -> string
end

external poll_event : unit -> Event.t option = "caml_SDL_PollEvent"
