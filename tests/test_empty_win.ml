open Osdl2
let () =
  Sdl.init [`VIDEO];
  let width, height = (320, 240) in
  let _ =
    Sdl.Window.create2
      ~title:"Let's try SDL2 with OCaml!"
      ~x:`undefined ~y:`undefined ~width ~height
      ~flags:[]
  in
  Sdl.Timer.delay ~ms:500;
  Sdl.quit ()
