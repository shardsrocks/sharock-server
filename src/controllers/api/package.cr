module Sharock::Controllers::API
  class PackageController
    def initialize(@services)
    end

    def find_one_by_github(env)
      find_one(env, "github")
    end

    protected def find_one(env, host)
      owner = env.params["owner"]
      repo = env.params["repo"]

      if owner.is_a? String && repo.is_a? String
        package = @services.package.find_one(host, owner, repo)

        if @services.package.needs_syncing(package)
          @services.resolver.sync(host, owner, repo)
        end

        return package.to_json
      end

      raise "Invalid parameters"
    end
  end
end
