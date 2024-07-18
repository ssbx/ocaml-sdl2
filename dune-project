(lang dune 3.15)

(name caml-sdl2)
(version 1.0)

(generate_opam_files true)

(source
  (github ssbx/caml-sdl2))

(authors "Seb")

(maintainers "Seb")

(license "BSD Zero Clause License")

(documentation https://github.com/ssbx/caml-sdl2)

(use_standard_c_and_cxx_flags true)

(formatting (enabled_for ocaml))

(package
  (name caml-sdl2)
  (synopsis "Bindings to the SDL2 library")
  (description "Bindings to the SDL2 library")
  (depends ocaml dune conf-sdl2)
  (tags
    (topics autio bindings graphics media opengl input)))

