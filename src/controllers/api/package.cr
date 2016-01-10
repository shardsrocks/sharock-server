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

    def fetch_by_github(env)
      fetch(env, "github")
    end

    def search_recent_updated(env)
      count_param = env.params["count"]?
      count = if count_param.is_a? String
                count_param.to_i?
              end
      count ||= 10
      packages = @package_service.search_recent_updated(count)
      return packages.to_json
    end

    protected def fetch(env, host)
      owner = env.params["owner"]
      repo = env.params["repo"]

      if owner.is_a? String && repo.is_a? String
        package = @package_service.fetch_package_result(host, owner, repo)
        @resolver_service.sync_if_needs(host, owner, repo)
        return package.to_json
      end

      raise "Invalid parameters"
    end
  end
end
