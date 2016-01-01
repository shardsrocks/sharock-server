require "kemal"
require "mysql"

require "./entities/*"
require "./resources/all"
require "./services/all"
require "./controllers/*"

include Sharock::Controllers::API
include Sharock::Services
include Sharock::Resources

conn = MySQL.connect("localhost", "root", "", "sharock", 3306_u16, nil)

resources = AllResources.new(conn)
services = AllServices.new(resources)
package_ctrl = PackageController.new(services)

get "/" do
  p resources.package.find
end

get "/api/package/github/:owner/:repo" do |env|
  # package_ctrl.find_one_by_github(env)
  package_ctrl.sync_by_github(env)
end

post "/api/package/github/:owner/:repo/sync" do |env|
  package_ctrl.sync_by_github(env)
end
