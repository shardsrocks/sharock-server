CRYSTAL  := crystal

SRC_NAME := api_server
APP_NAME := sharock-api-server

.PHONY: default build

default: clean install build

install:
	$(CRYSTAL) deps

build:
	mkdir -p bin
	$(CRYSTAL) build src/$(SRC_NAME).cr -o bin/$(APP_NAME)

clean:
	rm -rf .crystal
	rm -rf .shards
	rm -rf libs

