(lang dune 3.15)

(name caml-sdl2)
(version 1.0)

(generate_opam_files true)

(source
  (github ssbx/caml-sdl2))

(authors "Seb")

(maintainers "Seb")

(license "GPL-3.0-or-later")

(documentation https://github.com/ssbx/caml-sdl2)

(use_standard_c_and_cxx_flags true)

(formatting (enabled_for ocaml))

(package
  (name caml-sdl2)
  (synopsis "Bindings to the SDL2 library")
  (description "Bindings to the SDL2 library")
  (depends conf-sdl2)
  (tags
    (topics autio bindings graphics media opengl input)))

