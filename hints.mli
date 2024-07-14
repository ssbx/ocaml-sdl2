
(** API Doc:
  {{:http://wiki.libsdl.org/SDL2/CategoryHints}SDL_Hints} *)

external get : string -> string option = "caml_SDL_GetHint"
external set : string -> string -> unit = "caml_SDL_SetHint"
external set_with_prio : string -> string -> HintPriority.t -> unit
  = "caml_SDL_SetHintWithPriority"

