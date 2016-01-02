# sharock-api-server

## Requirements

- Crystal v0.10.0
- MySQL
- Redis
- [goworker](https://github.com/benmanns/goworker) ([Resque](https://github.com/benmanns/goworker) compatible)

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
