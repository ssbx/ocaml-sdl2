open Osdl

let () =
  SDL2.init [`VIDEO];
  let width, height = (320, 240) in
  let _ =
    SDL2.Window.create2
      ~title:"Let's try SDL2 with OCaml!"
      ~x:`undefined ~y:`undefined ~width ~height
      ~flags:[]
  in
  SDL2.Timer.delay ~ms:500;
  SDL2.quit ()
