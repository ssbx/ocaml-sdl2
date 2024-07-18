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
	dune build @doc && $(BROWSER) _build/default/_doc/_html/caml-libsdl2/CamlSDL2/SDL/index.html

dev_update:
	opam install -v --working-dir ./caml-libsdl2.opam
