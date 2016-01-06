require "kemal"
require "mysql"
require "redis"

require "./config/*"
require "./connections/*"
require "./controllers/*"
require "./entities/*"
require "./resources/all"
require "./services/all"

include Sharock::Connections
include Sharock::Controllers::API
include Sharock::Resources
include Sharock::Services

db = MySQLConnection.new("localhost", "root", "", "sharock", 3306_u16)
redis = Redis.new

resources = AllResources.new(db, redis)
services = AllServices.new(resources)
package_ctrl = PackageController.new(services)

get "/" do |env|
  "Hello Sharock"
end

get "/package/github/:owner/:repo" do |env|
  env.add_header "Access-Control-Allow-Origin", "*"
  package_ctrl.find_one_by_github(env)
end
