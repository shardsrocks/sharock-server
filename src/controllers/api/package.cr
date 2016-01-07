require "../../services/package"
require "../../services/resolver"

module Sharock::Controllers::API
  class PackageController
    include Services

    def initialize(
      @package_service = PackageService.new,
      @resolver_service = ResolverService.new
    )
    end

    def find_one_by_github(env)
      find_one(env, "github")
    end

    protected def find_one(env, host)
      owner = env.params["owner"]
      repo = env.params["repo"]

      if owner.is_a? String && repo.is_a? String
        package = @package_service.find_one(host, owner, repo)

        if @package_service.needs_syncing(package)
          @resolver_service.sync(host, owner, repo)
        end

        return package.to_json
      end

      raise "Invalid parameters"
    end
  end
end
