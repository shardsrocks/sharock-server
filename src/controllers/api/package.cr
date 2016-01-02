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
        return package.to_json
      end

      return render_404
    end

    def sync_by_github(env)
      sync(env, "github")
    end

    def sync(env, host)
      owner = env.params["owner"]
      repo = env.params["repo"]

      if owner.is_a? String && repo.is_a? String
        @services.resolver.sync(host, owner, repo)
        return { "ok": true }.to_json
      end

      return render_404
    end
  end
end
