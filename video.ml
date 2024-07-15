
(**
   {{https://wiki.libsdl.org/SDL2/CategoryVideo}CategoryVideo} *)

module WindowEventID = struct

  type point = {
    x: int;
    y: int;
  }

  type t =
    | SDL_WINDOWEVENT_NONE
    | SDL_WINDOWEVENT_SHOWN
    | SDL_WINDOWEVENT_HIDDEN
    | SDL_WINDOWEVENT_EXPOSED
    | SDL_WINDOWEVENT_MOVED of point
    | SDL_WINDOWEVENT_RESIZED of point
    | SDL_WINDOWEVENT_SIZE_CHANGED of point
    | SDL_WINDOWEVENT_MINIMIZED
    | SDL_WINDOWEVENT_MAXIMIZED
    | SDL_WINDOWEVENT_RESTORED
    | SDL_WINDOWEVENT_ENTER
    | SDL_WINDOWEVENT_LEAVE
    | SDL_WINDOWEVENT_FOCUS_GAINED
    | SDL_WINDOWEVENT_FOCUS_LOST
    | SDL_WINDOWEVENT_CLOSE
    | SDL_WINDOWEVENT_TAKE_FOCUS
    | SDL_WINDOWEVENT_HIT_TEST

  let string_of_id = function
    | SDL_WINDOWEVENT_NONE          -> "SDL_WINDOWEVENT_NONE"
    | SDL_WINDOWEVENT_SHOWN         -> "SDL_WINDOWEVENT_SHOWN"
    | SDL_WINDOWEVENT_HIDDEN        -> "SDL_WINDOWEVENT_HIDDEN"
    | SDL_WINDOWEVENT_EXPOSED       -> "SDL_WINDOWEVENT_EXPOSED"
    | SDL_WINDOWEVENT_MINIMIZED     -> "SDL_WINDOWEVENT_MINIMIZED"
    | SDL_WINDOWEVENT_MAXIMIZED     -> "SDL_WINDOWEVENT_MAXIMIZED"
    | SDL_WINDOWEVENT_RESTORED      -> "SDL_WINDOWEVENT_RESTORED"
    | SDL_WINDOWEVENT_ENTER         -> "SDL_WINDOWEVENT_ENTER"
    | SDL_WINDOWEVENT_LEAVE         -> "SDL_WINDOWEVENT_LEAVE"
    | SDL_WINDOWEVENT_FOCUS_GAINED  -> "SDL_WINDOWEVENT_FOCUS_GAINED"
    | SDL_WINDOWEVENT_FOCUS_LOST    -> "SDL_WINDOWEVENT_FOCUS_LOST"
    | SDL_WINDOWEVENT_CLOSE         -> "SDL_WINDOWEVENT_CLOSE"
    | SDL_WINDOWEVENT_TAKE_FOCUS    -> "SDL_WINDOWEVENT_TAKE_FOCUS"
    | SDL_WINDOWEVENT_HIT_TEST      -> "SDL_WINDOWEVENT_HIT_TEST"
    | SDL_WINDOWEVENT_MOVED p ->
        Printf.sprintf "SDL_WINDOWEVENT_MOVED(%d, %d)" p.x p.y
    | SDL_WINDOWEVENT_RESIZED p ->
        Printf.sprintf "SDL_WINDOWEVENT_RESIZED(%d, %d)" p.x p.y
    | SDL_WINDOWEVENT_SIZE_CHANGED p->
        Printf.sprintf "SDL_WINDOWEVENT_SIZE_CHANGED(%d, %d)" p.x p.y
end

module GLattr = struct
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

module GLcontext = struct
  type t
end

module Window = struct
  type t
end

module WindowFlags = struct
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
end

module WindowPos = struct
  type t = [ `centered | `undefined | `pos of int ]
end

external gl_create_context : win:Window.t -> GLcontext.t
  = "caml_SDL_GL_CreateContext"

external gl_make_current :
  win:Window.t -> ctx:GLcontext.t -> int
  = "caml_SDL_GL_MakeCurrent"

external gl_unload_library : unit -> unit
  = "caml_SDL_GL_UnloadLibrary"

external gl_extension_supported : extension:string -> bool
  = "caml_SDL_GL_ExtensionSupported"

external gl_set_swap_interval : interval:int -> unit
  = "caml_SDL_GL_SetSwapInterval"

external gl_get_swap_interval : unit -> int
  = "caml_SDL_GL_GetSwapInterval"

external gl_swap_window : Window.t -> unit
  = "caml_SDL_GL_SwapWindow"

external gl_delete_context : GLcontext.t -> unit
  = "caml_SDL_GL_DeleteContext"

external set_attribute : GLattr.t -> int -> unit
  = "caml_SDL_GL_SetAttribute"

external get_attribute : GLattr.t -> int
  = "caml_SDL_GL_GetAttribute"

external create_window :
  title:string ->
  pos:WindowPos.t * WindowPos.t ->
  dims:int * int ->
  flags:WindowFlags.t list -> Window.t
  = "caml_SDL_CreateWindow"

external create_window_2 :
  title:string ->
  x:WindowPos.t ->
  y:WindowPos.t ->
  width:int ->
  height:int ->
  flags:WindowFlags.t list -> Window.t
  = "caml_SDL_CreateWindow2_bc"
    "caml_SDL_CreateWindow2"

external set_window_title : window:Window.t -> title:string -> unit
  = "caml_SDL_SetWindowTitle"

external show_window : Window.t -> unit = "caml_SDL_ShowWindow"
external hide_window : Window.t -> unit = "caml_SDL_HideWindow"
external raise_window : Window.t -> unit = "caml_SDL_RaiseWindow"
external maximize_window: Window.t -> unit = "caml_SDL_MaximizeWindow"
external minimize_window : Window.t -> unit = "caml_SDL_MinimizeWindow"
external restore_window : Window.t -> unit = "caml_SDL_RestoreWindow"

external get_window_surface :
  Window.t -> Surface.surface_t
  = "caml_SDL_GetWindowSurface"

external update_window_surface : Window.t -> unit
  = "caml_SDL_UpdateWindowSurface"

external set_window_brightness : Window.t -> brightness:float -> unit
  = "caml_SDL_SetWindowBrightness"

external get_window_brightness : Window.t -> float
  = "caml_SDL_GetWindowBrightness"

external destroy_window : Window.t -> unit
  = "caml_SDL_DestroyWindow"

external get_window_size : Window.t -> (int * int)
  = "caml_SDL_GetWindowSize"
