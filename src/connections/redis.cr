require "redis"
require "pool/connection"

module Sharock::Connections
  class RedisConnection
    def initialize(capacity = 25, timeout = 0.1)
      @pool = ConnectionPool(Redis).new(capacity: capacity, timeout: timeout) do
        ::Redis.new
      end
    end

    def connect
      @pool.connection do |conn|
        yield conn
      end
    end
  end
end
