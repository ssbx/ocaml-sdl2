
(**
   {{https://wiki.libsdl.org/SDL2/CategoryPower}CategoryPower} *)

module PowerState = struct
  type t = [
    | `powerstate_Unknown      (** cannot determine power status *)
    | `powerstate_On_Battery   (** Not plugged in, running on the battery *)
    | `powerstate_No_Battery   (** Plugged in, no battery available *)
    | `powerstate_Charging     (** Plugged in, charging battery *)
    | `powerstate_Charged      (** Plugged in, battery charged *)
  ]
end

external get_power_info : unit -> PowerState.t * int * int
  = "caml_SDL_GetPowerInfo"

