.PHONY: build clean test fmt doc dev_update

build:
	dune build

clean:
	dune clean

test:
	dune runtest -f

fmt:
	dune build @fmt
	@echo 'run "dune promote" to update files'

doc:
	dune build @doc && $(BROWSER) _build/default/_doc/_html/caml-sdl2/CamlSDL2/Sdl/index.html

dev_update: clean
	opam install -v --working-dir ./caml-sdl2.opam
