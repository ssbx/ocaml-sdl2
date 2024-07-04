open Osdl2
let () =
  Osdl2.init [`VIDEO];
  let width, height = (320, 240) in
  let _ =
    Window.create2
      ~title:"Let's try SDL2 with OCaml!"
      ~x:`undefined ~y:`undefined ~width ~height
      ~flags:[]
  in
  Timer.delay ~ms:500;
  Osdl2.quit ()
