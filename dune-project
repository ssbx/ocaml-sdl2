(lang dune 3.15)

(name osdl)
(version 2.0)

(generate_opam_files true)

(source
 (github ssbx/osdl))

(authors "Seb")

(maintainers "Seb")

(license "BSD Zero Clause License")

(documentation https://github.com/ssbx/osdl)

(use_standard_c_and_cxx_flags true)

(package
 (name osdl)
 (synopsis "Bindings to the SDL2 library")
 (description "Bindings to the SDL2 library")
 (depends ocaml dune conf-sdl2)
 (tags
  (topics autio bindings graphics media opengl input)))

; See the complete stanza docs at https://dune.readthedocs.io/en/stable/dune-files.html#dune-project
