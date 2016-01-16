CRYSTAL  := crystal
DEVELOP_OPT :=

RELEASE_OPT := --release

SERVER_SRC := api_server.cr
SERVER_BIN := sharock-api-server
WORKER_SRC := worker.cr
WORKER_BIN := sharock-worker

.PHONY: default build

default: clean install build

install:
	$(CRYSTAL) deps

build:
	$(CRYSTAL) build src/$(SERVER_SRC) -o bin/$(SERVER_BIN) $(DEVELOP_OPT)
	$(CRYSTAL) build src/$(WORKER_SRC) -o bin/$(WORKER_BIN) $(DEVELOP_OPT)

release:
	$(CRYSTAL) build src/$(SERVER_SRC) -o bin/$(SERVER_BIN) $(RELEASE_OPT)
	$(CRYSTAL) build src/$(WORKER_SRC) -o bin/$(WORKER_BIN) $(RELEASE_OPT)

clean:
	rm -rf .crystal
	rm -rf .shards
	rm -rf libs

