CRYSTAL := crystal

.PHONY: default build

default: clean install build

install:
	$(CRYSTAL) deps

build:
	mkdir -p bin
	$(CRYSTAL) build src/resolver.cr -o bin/resolver

release:
	mkdir -p bin
	$(CRYSTAL) build src/resolver.cr -o bin/resolver --release

clean:
	rm -rf .crystal
	rm -rf .shards
	rm -rf libs
