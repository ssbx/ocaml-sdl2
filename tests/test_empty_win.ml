let () =
  Osdl2.init [`SDL_INIT_VIDEO];
  let width, height = (320, 240) in
  let _ =
    Osdl2.create_window_2
      ~title:"Let's try SDL2 with OCaml!"
      ~x:`undefined ~y:`undefined ~width ~height
      ~flags:[]
  in
  Osdl2.delay ~ms:500;
  Osdl2.quit ()
