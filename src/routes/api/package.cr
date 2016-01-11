require "kemal"

require "../../controllers/api"

module Sharock::Routes::API
  class Package
    include Controllers

    def self.register
      @@route = Sharock::Routes::API::Package.new.register
    end

    protected def initialize(
      @package_controller = API::PackageController.new
    )
    end

    def register
      get "/api/package/github/:owner/:repo" do |env|
        if Kemal.config.env == "development"
          env.add_header "Access-Control-Allow-Origin", "*"
        end
        @package_controller.fetch_by_github(env)
      end

      get "/api/package/recent_updated" do |env|
        if Kemal.config.env == "development"
          env.add_header "Access-Control-Allow-Origin", "*"
        end
        @package_controller.search_recent_updated(env)
      end
    end
  end
end
