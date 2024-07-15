(**
   {{https://wiki.libsdl.org/SDL2/CategoryAudio}CategoryAudio} *)

module AudioBuffer   = struct type t end
module AudioDeviceID = struct type t end
module AudioSpec     = struct type t end
module AudioStream   = struct type t end

module AudioFormat = struct
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

module  AudioStatus = struct
  type t =
    | Stopped
    | Playing
    | Paused

  let to_string = function
    | Stopped -> "Stopped"
    | Playing -> "Playing"
    | Paused  -> "Paused"

  let of_string = function
    | "Stopped" -> Stopped
    | "Playing" -> Playing
    | "Paused"  -> Paused
    | str       -> invalid_arg str
end

(** Ocasdl internals *)
external new_audio_spec : unit -> AudioSpec.t
  = "caml_SDL_alloc_audio_spec"

(** Ocasdl internals *)
external free_audio_spec : AudioSpec.t -> unit
  = "caml_SDL_free_audio_spec"

external get_audio_drivers : unit -> string array
  = "caml_SDL_GetAudioDrivers"

external audio_init : driver_name:string -> unit
  = "caml_SDL_AudioInit"

external audio_quit : unit -> unit
  = "caml_SDL_AudioQuit"

external get_current_audio_driver : unit -> string
  = "caml_SDL_GetCurrentAudioDriver"

external get_audio_status : unit -> AudioStatus.t
  = "caml_SDL_GetAudioStatus"

external pause_audio : pause_on:bool -> unit
  = "caml_SDL_PauseAudio"

external lock_audio : unit -> unit
  = "caml_SDL_LockAudio"

external unlock_audio : unit -> unit
  = "caml_SDL_UnlockAudio"

external close_audio : unit -> unit
  = "caml_SDL_CloseAudio"

external load_wav : filename:string -> spec:AudioSpec.t -> AudioBuffer.t * int32
  = "caml_SDL_LoadWAV"

external free_wav : AudioBuffer.t -> unit
  = "caml_SDL_FreeWAV"

external open_audio_device_simple : AudioSpec.t -> AudioDeviceID.t
  = "caml_SDL_OpenAudioDevice_simple"

external queue_audio : AudioDeviceID.t -> AudioBuffer.t -> int32 -> unit
  = "caml_SDL_QueueAudio"

external unpause_audio_device : AudioDeviceID.t -> unit
  = "caml_SDL_UnpauseAudioDevice"

external pause_audio_device : AudioDeviceID.t -> unit
  = "caml_SDL_PauseAudioDevice"

external close_audio_device : AudioDeviceID.t -> unit
  = "caml_SDL_CloseAudioDevice"
