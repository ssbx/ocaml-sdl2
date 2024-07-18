open CamlSDL2

let () =
  SDL.init [ `SDL_INIT_VIDEO ];
  let width, height = 320, 240 in
  let _ =
    SDL.create_window
      ~title:"Let's try SDL2 with OCaml!"
      ~x:`undefined
      ~y:`undefined
      ~width
      ~height
      ~flags:[]
  in
  SDL.delay ~ms:500;
  SDL.quit ()
;;
