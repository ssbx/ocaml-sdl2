(**
   {{https://wiki.libsdl.org/SDL2/CategoryEvents}CategoryEvents} *)

open Keycode
open Scancode

module KeyState = struct
  type t =
    | SDL_RELEASED
    | SDL_PRESSED

  let to_string = function
    | SDL_RELEASED -> "SDL_RELEASED"
    | SDL_PRESSED  -> "SDL_PRESSED"
end

module KeyboardEvent = struct
  type t = {
    ke_timestamp: int32;
    ke_window_id: int32;
    ke_state: KeyState.t;
    ke_repeat: int;
    scancode: Scancode.t;
    keycode: Keycode.t;
    keymod: Keymod.t list;
  }
end

module MouseMotionEvent = struct
  type t = {
    mm_timestamp: int32;
    mm_window_id: int32;
    mm_buttons: int list;
    mm_x: int;
    mm_y: int;
    mm_xrel: int;
    mm_yrel: int;
  }
end

module MouseButtonEvent = struct
  type t = {
    mb_timestamp: int32;
    mb_window_id: int32;
    mb_button: int;
    mb_state: KeyState.t;
    mb_x: int;
    mb_y: int;
  }
end

module MouseWheelEvent = struct
  type t = {
    mw_timestamp: int32;
    mw_window_id: int32;
    mw_x: int;
    mw_y: int;
  }
end

module JoyAxisEvent = struct
  type t = {
    ja_timestamp: int32;
    ja_which: int;
    ja_axis: int;
    ja_value: int;
  }
end

module JoyButtonEvent = struct
  type t = {
    jb_timestamp: int32;
    jb_which: int;
    jb_button: int;
    jb_state: KeyState.t;
  }
end

module JoyHatEvent = struct
  type t = {
    jh_timestamp: int32;
    jh_which: int;
    jh_hat: int;
    jh_dir: Haptic.direction;
    jh_pos: Haptic.positions;
  }
end

module JoyDeviceEvent = struct
  type event_type =
    | SDL_JOYDEVICEADDED
    | SDL_JOYDEVICEREMOVED

  let to_string = function
    | SDL_JOYDEVICEADDED -> "SDL_JOYDEVICEADDED"
    | SDL_JOYDEVICEREMOVED -> "SDL_JOYDEVICEREMOVED"

  type t = {
    jd_timestamp: int32;
    jd_which: int;
    jd_change: event_type;
  }
end

module WindowEvent = struct
  type t = {
    we_timestamp: int32;
    window_ID:    int32;
    kind :        Video.WindowEventID.t;
  }
end

module QuitEvent = struct
  type t = {
    quit_timestamp: int32;
  }
end

module TextEditingEvent = struct
  type t = {
    te_timestamp: int32;
    te_window_ID: int32;
    te_text: string;
    te_begin: int;
    te_length: int;
  }
end

module TextInputEvent = struct
  type t = {
    ti_timestamp: int32;
    ti_window_ID: int32;
    ti_text: string;
  }
end

module Event = struct
  type t =
    | SDL_QUIT              of QuitEvent.t
    | SDL_MOUSEMOTION       of MouseMotionEvent.t
    | SDL_MOUSEBUTTONDOWN   of MouseButtonEvent.t
    | SDL_MOUSEBUTTONUP     of MouseButtonEvent.t
    | SDL_MOUSEWHEEL        of MouseWheelEvent.t
    | SDL_KEYDOWN           of KeyboardEvent.t
    | SDL_KEYUP             of KeyboardEvent.t
    | SDL_TEXTEDITING       of TextEditingEvent.t
    | SDL_TEXTINPUT         of TextInputEvent.t
    | SDL_JOYAXISMOTION     of JoyAxisEvent.t
    | SDL_JOYBALLMOTION
    | SDL_JOYHATMOTION      of JoyHatEvent.t
    | SDL_JOYBUTTONDOWN     of JoyButtonEvent.t
    | SDL_JOYBUTTONUP       of JoyButtonEvent.t
    | SDL_JOYDEVICEADDED    of JoyDeviceEvent.t
    | SDL_JOYDEVICEREMOVED  of JoyDeviceEvent.t
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
    | SDL_WINDOWEVENT       of WindowEvent.t
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

   let to_string = function
    | SDL_QUIT _ -> "SDL_QUIT"
    | SDL_MOUSEMOTION _ -> "SDL_MOUSEMOTION"
    | SDL_MOUSEBUTTONDOWN _ -> "SDL_MOUSEBUTTONDOWN"
    | SDL_MOUSEBUTTONUP _ -> "SDL_MOUSEBUTTONUP"
    | SDL_MOUSEWHEEL _ -> "SDL_MOUSEWHEEL"
    | SDL_KEYDOWN _ -> "SDL_KEYDOWN"
    | SDL_KEYUP _ -> "SDL_KEYUP"
    | SDL_TEXTEDITING _ -> "SDL_TEXTEDITING"
    | SDL_TEXTINPUT _ -> "SDL_TEXTINPUT"
    | SDL_JOYAXISMOTION _ -> "SDL_JOYAXISMOTION"
    | SDL_JOYBALLMOTION -> "SDL_JOYBALLMOTION"
    | SDL_JOYHATMOTION _ -> "SDL_JOYHATMOTION"
    | SDL_JOYBUTTONDOWN _ -> "SDL_JOYBUTTONDOWN"
    | SDL_JOYBUTTONUP _ -> "SDL_JOYBUTTONUP"
    | SDL_JOYDEVICEADDED _ -> "SDL_JOYDEVICEADDED"
    | SDL_JOYDEVICEREMOVED _ -> "SDL_JOYDEVICEREMOVED"
    | SDL_CONTROLLERAXISMOTION -> "SDL_CONTROLLERAXISMOTION"
    | SDL_CONTROLLERBUTTONDOWN -> "SDL_CONTROLLERBUTTONDOWN"
    | SDL_CONTROLLERBUTTONUP -> "SDL_CONTROLLERBUTTONUP"
    | SDL_CONTROLLERDEVICEADDED -> "SDL_CONTROLLERDEVICEADDED"
    | SDL_CONTROLLERDEVICEREMOVED -> "SDL_CONTROLLERDEVICEREMOVED"
    | SDL_CONTROLLERDEVICEREMAPPED -> "SDL_CONTROLLERDEVICEREMAPPED"
    | SDL_FINGERDOWN -> "SDL_FINGERDOWN"
    | SDL_FINGERUP -> "SDL_FINGERUP"
    | SDL_FINGERMOTION -> "SDL_FINGERMOTION"
    | SDL_DOLLARGESTURE -> "SDL_DOLLARGESTURE"
    | SDL_DOLLARRECORD -> "SDL_DOLLARRECORD"
    | SDL_MULTIGESTURE -> "SDL_MULTIGESTURE"
    | SDL_CLIPBOARDUPDATE -> "SDL_CLIPBOARDUPDATE"
    | SDL_DROPFILE -> "SDL_DROPFILE"
    | SDL_USEREVENT -> "SDL_USEREVENT"
    | SDL_WINDOWEVENT _ -> "SDL_WINDOWEVENT"
    | SDL_SYSWMEVENT -> "SDL_SYSWMEVENT"
    | SDL_APP_TERMINATING -> "SDL_APP_TERMINATING"
    | SDL_APP_LOWMEMORY -> "SDL_APP_LOWMEMORY"
    | SDL_APP_WILLENTERBACKGROUND -> "SDL_APP_WILLENTERBACKGROUND"
    | SDL_APP_DIDENTERBACKGROUND -> "SDL_APP_DIDENTERBACKGROUND"
    | SDL_APP_WILLENTERFOREGROUND -> "SDL_APP_WILLENTERFOREGROUND"
    | SDL_APP_DIDENTERFOREGROUND -> "SDL_APP_DIDENTERFOREGROUND"
    | SDL_DISPLAYEVENT -> "SDL_DISPLAYEVENT"
    | SDL_KEYMAPCHANGED -> "SDL_KEYMAPCHANGED"
    | SDL_DROPTEXT -> "SDL_DROPTEXT"
    | SDL_DROPBEGIN -> "SDL_DROPBEGIN"
    | SDL_DROPCOMPLETE -> "SDL_DROPCOMPLETE"
    | SDL_AUDIODEVICEADDED -> "SDL_AUDIODEVICEADDED"
    | SDL_AUDIODEVICEREMOVED -> "SDL_AUDIODEVICEREMOVED"
    | SDL_SENSORUPDATE -> "SDL_SENSORUPDATE"
    | SDL_RENDER_TARGETS_RESET -> "SDL_RENDER_TARGETS_RESET"
    | SDL_RENDER_DEVICE_RESET -> "SDL_RENDER_DEVICE_RESET"
end

external poll_event : unit -> Event.t option
  = "caml_SDL_PollEvent"

