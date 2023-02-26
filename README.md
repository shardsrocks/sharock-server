# Sharock Server
[![Circle CI](https://img.shields.io/circleci/project/shardsrocks/sharock-server/master.svg)](https://circleci.com/gh/shardsrocks/sharock-server/tree/master)
[![Dependency Status](https://shards.rocks/badge/github/shardsrocks/sharock-api-server/status.svg)](https://shards.rocks/github/shardsrocks/sharock-api-server)
[![Dependency Status](https://shards.rocks/badge/github/shardsrocks/sharock-api-server/dev_status.svg)](https://shards.rocks/github/shardsrocks/sharock-api-server)

## Requirements

- Crystal v0.10.2 try https://github.com/crenv/crenv and Ubuntu 18.04 in a VM to compile all easier
- MySQL
- Redis
- [goworker](https://github.com/benmanns/goworker) ([Resque](https://github.com/benmanns/goworker) compatible)

> Note: if you get a libssl1.0-dev bug check this: https://bugs.launchpad.net/ubuntu/+source/mysql-5.7/+bug/1861304

## Design

- Use [kemal](https://github.com/sdogruyol/kemal)
- The 4 layers architecture
  - Entity (= Model)
  - Resource (= DB / Redis)
  - Service (= Business logic)
  - Controller

## Getting started

```
$ make
```

## License
MIT License

