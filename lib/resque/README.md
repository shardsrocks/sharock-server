# crystal-resque-client [![Build Status](https://travis-ci.org/pine613/crystal-resque-client.svg?branch=master)](https://travis-ci.org/pine613/crystal-resque-client)

Simple [Resque](https://github.com/resque/resque) queue client for [Crystal](http://crystal-lang.org/) inspired by [go-resque](https://github.com/kavu/go-resque).

## Installation

Add this to your application's `shard.yml`:

```yaml
dependencies:
  resque_client:
    github: pine613/crystal-resque-client
    branch: master
  redis:
    github: stefanwille/crystal-redis
    version: ~> 1.2.1
```


## Usage

```crystal
require "redis"
require "resque_client"

redis = Redis.new
enqueuer = Resque::Client::Enqueuer.new(redis)

enqueuer.enqueue("Class", "arg1", 1000, true)
```

## Contributing

1. Fork it ( https://github.com/pine613/crystal-resque-client/fork )
2. Create your feature branch (git checkout -b my-new-feature)
3. Commit your changes (git commit -am 'Add some feature')
4. Push to the branch (git push origin my-new-feature)
5. Create a new Pull Request

## Contributors

- [pine613](https://github.com/pine613) Pine Mizune - creator, maintainer
