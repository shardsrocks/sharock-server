require "mysql"
require "pool/connection"

module Sharock::Connections
  class MySQLConnection

    def initialize(host, user, password, db, port = 3306_u16, capacity = 25, timeout = 0.1)
      @pool = ConnectionPool(MySQL::Connection).new(capacity: capacity, timeout: timeout) do
        ::MySQL.connect(host, user, password, db, port, nil)
      end
    end

    def connect
      @pool.connection do |conn|
        yield conn
      end
    end
  end
end
