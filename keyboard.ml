(**
   {{https://wiki.libsdl.org/SDL2/CategoryKeyboard}CategoryKeyboard} *)

external start_text_input : unit -> unit
  = "caml_SDL_StartTextInput"

external stop_text_input : unit -> unit
  = "caml_SDL_StopTextInput"

external is_text_input_active : unit -> bool
  = "caml_SDL_IsTextInputActive"

external set_text_input_rect : Rect.rect_t -> unit
  = "caml_SDL_SetTextInputRect"

external has_screen_keyboard_support : unit -> bool
  = "caml_SDL_HasScreenKeyboardSupport"


