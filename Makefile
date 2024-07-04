.PHONY: build test t clean dev_install


build:
	dune build

clean:
	dune clean

t: test
test:
	dune runtest -f

dev_install: build
	opam install -v --working-dir ./osdl2.opam
