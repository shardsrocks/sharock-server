require "../connections/*"

module Sharock::Services
  def self.context : Context
    @@context.not_nil!
  end

  protected def self.context=(context : Context)
    @@context = context
  end

  class Context
    include Connections

    getter! mysql :: MySQLConnection
    getter! redis :: RedisConnection

    def self.bootstrap(
      mysql : MySQLConnection,
      redis : RedisConnection)

      Sharock::Services.context = Context.new(mysql, redis)
    end

    protected def initialize(@mysql, @redis)
    end
  end
end
