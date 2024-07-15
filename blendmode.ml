(**
   {{https://wiki.libsdl.org/SDL2/CategoryBlendmode}CategoryBlendmode} *)

module BlendMode = struct
  type t =
    | SDL_BLENDMODE_NONE
    | SDL_BLENDMODE_BLEND
    | SDL_BLENDMODE_ADD
    | SDL_BLENDMODE_MOD
    | SDL_BLENDMODE_MUL

  let to_string = function
    | SDL_BLENDMODE_NONE    -> "SDL_BLENDMODE_NONE"
    | SDL_BLENDMODE_BLEND   -> "SDL_BLENDMODE_BLEND"
    | SDL_BLENDMODE_ADD     -> "SDL_BLENDMODE_ADD"
    | SDL_BLENDMODE_MOD     -> "SDL_BLENDMODE_MOD"
    | SDL_BLENDMODE_MUL     -> "SDL_BLENDMODE_MUL"


  let of_string = function
    | "SDL_BLENDMODE_NONE"   -> SDL_BLENDMODE_NONE
    | "SDL_BLENDMODE_BLEND"  -> SDL_BLENDMODE_BLEND
    | "SDL_BLENDMODE_ADD"    -> SDL_BLENDMODE_ADD
    | "SDL_BLENDMODE_MOD"    -> SDL_BLENDMODE_MOD
    | "SDL_BLENDMODE_MUL"    -> SDL_BLENDMODE_MUL
    | invalid                -> invalid_arg (Printf.sprintf "BlendMode.t %s" invalid)
end

