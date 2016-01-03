module Sharock::Services
  class PackageService
    def initialize(@resources)
    end

    def find_one(host, owner, repo)
      package = @resources.package.find_one(host, owner, repo)
      package.try do |package|
        package_deps = @resources.package_deps.find_one_latest_version(package.id)
        package_deps.try do |package_deps|
          return Entities::Results::Package.new(package, package_deps)
        end
      end
    end

    def needs_syncing(package : Entities::Results::Package?)
      package.try do |package|
        # FIXME
        return false
      end

      true
    end
  end
end
