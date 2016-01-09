require "./config/*"
require "./connections/*"
require "./services/context"
require "./routes/*"

include Sharock::Connections

mysql = MySQLConnection.new("localhost", "root", "", "sharock", 3306_u16)
redis = RedisConnection.new

Sharock::Services::Context.bootstrap(mysql, redis)

Sharock::Routes::API.register
Sharock::Routes::Badge.register
Sharock::Routes::Keepalive.register
