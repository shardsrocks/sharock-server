require "../resources/db/package"
require "../resources/db/package_deps"

include Sharock::Resources

module Sharock::Services
  class PackageService
    def initialize(@pool)
    end

    def find_one(host, owner, repo)
      @pool.connect do |conn|
        package = PackageResource.new(conn).find_one(host, owner, repo)
        package.try do |package|
          package_deps = PackageDepsResource.new(conn).find_one_latest_version(package.id)
          package_deps.try do |package_deps|
            return Entities::Results::Package.new(package, package_deps)
          end
        end
      end
    end

    def update_deps(package_id, deps)
      @pool.connect do |conn|
        package_deps_resource = PackageDepsResource.new(conn)
        package_deps_resource.insert_deps(
          package_id,
          "unknown",
          "unknown",
          deps.to_json
        )
      end
    end

    def needs_syncing(package : Entities::Results::Package?)
      package.try do |package|
        package.package.sync_started_at.try do |sync_started_at|
          span = Time.now - sync_started_at
          return span.seconds > Config::CACHE_TIME_SEC
        end

        return true
      end

      return true
    end
  end
end
