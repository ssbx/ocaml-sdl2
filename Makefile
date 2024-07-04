.PHONY: build test t clean install


build:
	dune build

clean:
	dune clean

t: test
test:
	dune runtest -f

install: build
	opam install -v --working-dir ./osdl.opam
