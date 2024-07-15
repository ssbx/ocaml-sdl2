
(**
   {{https://wiki.libsdl.org/SDL2/CategoryHints}CategoryHints} *)

module HintPriority = struct
  type t = Default | Normal | Override

  let to_string = function
    | Default   -> "SDL_HINT_DEFAULT"
    | Normal    -> "SDL_HINT_NORMAL"
    | Override  -> "SDL_HINT_OVERRIDE"

  let of_string s =
    match String.uppercase_ascii s with
    | "SDL_HINT_DEFAULT"  -> Default
    | "SDL_HINT_NORMAL"   -> Normal
    | "SDL_HINT_OVERRIDE" -> Override
    | _ -> invalid_arg "Sdlhintpriority.of_string"
end

external get_hint : string -> string option
  = "caml_SDL_GetHint"

external set_hint : string -> string -> unit
  = "caml_SDL_SetHint"

external set_hint_with_priority : string -> string -> HintPriority.t -> unit
  = "caml_SDL_SetHintWithPriority"

