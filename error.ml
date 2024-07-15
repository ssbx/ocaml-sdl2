
(**
   {{https://wiki.libsdl.org/SDL2/CategoryError}CategoryError} *)

external get_error : unit -> string
  = "caml_SDL_GetError"

external clear_error : unit -> unit
  = "caml_SDL_ClearError"

