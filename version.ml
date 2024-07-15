
(**
   {{https://wiki.libsdl.org/SDL2/CategoryVersion}CategoryVersion} *)

module Version = struct
  type t = {
    major: int;
    minor: int;
    patch: int;
  }
end

external get_runtime_version : unit -> Version.t
  = "caml_SDL_GetRunTimeVersion"

external get_compiled_version : unit -> Version.t
  = "caml_SDL_GetCompiledVersion"

external get_revision_string : unit -> string
  = "caml_SDL_GetRevisionString"

external get_revision_number : unit -> int
  = "caml_SDL_GetRevisionNumber"


