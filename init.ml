module Subsystem = struct
  type t = [
  | `SDL_INIT_TIMER
  | `SDL_INIT_AUDIO
  | `SDL_INIT_VIDEO
  | `SDL_INIT_JOYSTICK
  | `SDL_INIT_HAPTIC
  | `SDL_INIT_GAMECONTROLLER
  | `SDL_INIT_EVENTS
  | `SDL_INIT_EVERYTHING
  | `SDL_INIT_NOPARACHUTE
  ]
end

external init : Subsystem.t list -> unit
  = "caml_SDL_Init"
(*[< subsystem | `EVERYTHING | `NOPARACHUTE ] list -> unit*)

external init_subsystem : Subsystem.t list -> unit
  = "caml_SDL_InitSubSystem"

external quit : unit -> unit
  = "caml_SDL_Quit"

external quit_requested : unit -> bool
  = "caml_SDL_QuitRequested"
