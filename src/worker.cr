require "./config/*"
require "./connections/*"
require "./services/context"
require "./workers/*"

include Sharock::Connections

MYSQL_HOST     = ENV["MYSQL_HOST"]?     || "127.0.0.1"
MYSQL_USER     = ENV["MYSQL_USER"]?     || "root"
MYSQL_PASSWORD = ENV["MYSQL_PASSWORD"]? || ""
MYSQL_DBNAME   = ENV["MYSQL_DBNAME"]?   || "sharock"

mysql = MySQLConnection.new(MYSQL_HOST, MYSQL_USER, MYSQL_PASSWORD, MYSQL_DBNAME, 3306_u16)
redis = RedisConnection.new

Sharock::Services::Context.bootstrap(mysql, redis)
Sharock::Workers::Resolver.run
