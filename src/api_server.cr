require "kemal"
# require "mysql"
require "redis"

require "./config/*"
require "./connections/*"
require "./controllers/*"
require "./entities/*"
require "./services/context"

include Sharock::Connections
include Sharock::Controllers
include Sharock::Controllers::API
include Sharock::Resources

mysql = MySQLConnection.new("localhost", "root", "", "sharock", 3306_u16)
redis = RedisConnection.new

Sharock::Services::Context.bootstrap(mysql, redis)

package_ctrl = PackageController.new
badge_ctrl = BadgeController.new


get "/" do |env|
  "Hello Sharock"
end

get "/api/package/github/:owner/:repo" do |env|
  env.add_header "Access-Control-Allow-Origin", "*"
  package_ctrl.find_one_by_github(env)
end

# get "/badge/github/:owner/:repo/status.svg" do |env|
#   badge_ctrl.fetch_status_svg(env)
# end
#
# get "/badge/github/:owner/:repo/dev_status.svg" do |env|
#   badge_ctrl.fetch_dev_status_svg(env)
# end
