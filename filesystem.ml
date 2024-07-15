(**
   {{https://wiki.libsdl.org/SDL2/CategoryFilesystem}CategoryFilesystem} *)

external get_base_path : unit -> string
  = "caml_SDL_GetBasePath"

external get_pref_path : org:string -> app:string -> string
  = "caml_SDL_GetPrefPath"

