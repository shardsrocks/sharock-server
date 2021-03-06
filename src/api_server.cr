require "./config/*"
require "./connections/*"
require "./services/context"
require "./routes/*"

include Sharock::Connections

MYSQL_HOST     = ENV["MYSQL_HOST"]?     || "localhost"
MYSQL_USER     = ENV["MYSQL_USER"]?     || "root"
MYSQL_PASSWORD = ENV["MYSQL_PASSWORD"]? || ""
MYSQL_DBNAME   = ENV["MYSQL_DBNAME"]?   || "sharock"

mysql = MySQLConnection.new(MYSQL_HOST, MYSQL_USER, MYSQL_PASSWORD, MYSQL_DBNAME, 3306_u16)
redis = RedisConnection.new

Sharock::Services::Context.bootstrap(mysql, redis)

Sharock::Routes::API::Keepalive.register
Sharock::Routes::API::Package.register
Sharock::Routes::Badge.register
