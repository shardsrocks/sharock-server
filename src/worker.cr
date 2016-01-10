require "./config/*"
require "./connections/*"
require "./services/context"
require "./routes/*"

include Sharock::Connections

mysql = MySQLConnection.new("localhost", "root", "", "sharock", 3306_u16)
redis = RedisConnection.new

Sharock::Services::Context.bootstrap(mysql, redis)
Sharock::Workers::Resolver.run
