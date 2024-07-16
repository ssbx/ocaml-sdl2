.PHONY: build test t clean dev_install doc


build:
	dune build

clean:
	dune clean

t: test
test:
	dune runtest -f

doc:
	dune build @doc && $(BROWSER) _build/default/_doc/_html/caml-libsdl2/Sdl/index.html

dev_install: build
	opam install -v --working-dir ./caml-libsdl2.opam
