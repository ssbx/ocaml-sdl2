
(**
   {{https://wiki.libsdl.org/SDL2/CategoryTimer}CategoryTimer} *)


external get_ticks : unit -> int = "caml_SDL_GetTicks" [@@noalloc]

external delay : ms:int -> unit = "caml_SDL_Delay"

