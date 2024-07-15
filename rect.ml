(* OCamlSDL2 - An OCaml interface to the SDL2 library
 Copyright (C) 2013 Florent Monnier

 This software is provided "AS-IS", without any express or implied warranty.
 In no event will the authors be held liable for any damages arising from
 the use of this software.

 Permission is granted to anyone to use this software for any purpose,
 including commercial applications, and to alter it and redistribute it freely.
*)
(** Rectangles *)

(** A rectangle, with the origin at the upper left. *)
module Rect = struct
  type t = {
    x: int;
    y: int;
    w: int;
    h: int;
  }

  let make1 (x, y, w, h) =
    { x; y; w; h }

  let make2 ~pos:(x, y) ~dims:(w, h) =
    { x; y; w; h }

  let make4 ~x ~y ~w ~h =
    { x; y; w; h }

  let make = make2

end

module Point = struct
  type t = {
    x: int;
    y: int;
  }
end

external has_intersection : a:Rect.t -> b:Rect.t -> bool
  = "caml_SDL_HasIntersection"

external intersect_rect_and_line : rect:Rect.t ->
  x1:int -> y1:int -> x2:int -> y2:int -> (int * int * int * int) option
  = "caml_SDL_IntersectRectAndLine"

external point_in_rect : p:Point.t -> r:Rect.t -> bool
  = "caml_SDL_PointInRect"
