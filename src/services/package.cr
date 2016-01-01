module Sharock::Services
  class PackageService
    def initialize(@resources)
    end

    def find_one(host, owner, repo)
      package = @resources.package.find_one(host, owner, repo)
      package.try do |package|
        package_deps = @resources.package_deps.find_one_latest_version(package.id)
        return Entities::Results::Package.new(package, package_deps)
      end
    end
  end
end
