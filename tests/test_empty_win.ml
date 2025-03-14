open CamlSDL2

let () =
  Sdl.init [ `VIDEO ];
  let width, height = 320, 240 in
  let _ =
    Sdl.create_window
      ~title:"Let's try SDL2 with OCaml!"
      ~x:`undefined
      ~y:`undefined
      ~width
      ~height
      ~flags:[]
  in
  Sdl.delay ~ms:500;
  Sdl.quit ()
;;
