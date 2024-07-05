
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

