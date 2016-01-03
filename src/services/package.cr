module Sharock::Services
  class PackageService
    def initialize(@resources)
    end

    def find_one(host, owner, repo)
      @resources.db.connect do |conn|
        package = @resources.package(conn).find_one(host, owner, repo)
        package.try do |package|
          package_deps = @resources.package_deps(conn).find_one_latest_version(package.id)
          package_deps.try do |package_deps|
            return Entities::Results::Package.new(package, package_deps)
          end
        end
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
