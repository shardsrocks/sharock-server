require "../config/assets"
require "../resources/db/package"
require "../resources/db/package_deps"


module Sharock::Services
  class PackageService
    include Sharock::Resources::DB

    def initialize(@context = Services.context)
    end

    def fetch_package(host, owner, repo)
      @context.mysql.connect do |conn|
        package = PackageResource.new(conn).find_one(host, owner, repo)
        package.try do |package|
          package_deps = PackageDepsResource.new(conn).find_one_latest_version(package.id)
          package_deps.try do |package_deps|
            return Entities::Results::Package.new(
              package,
              package_deps,
              fetch_badge_url(package, false),
              fetch_badge_url(package, true)
            )
          end
        end
      end
    end

    def search_recent_updated(count : Int)
      @context.mysql.connect do |conn|
        package_resource = PackageResource.new(conn)
        package_deps_resource = PackageDepsResource.new(conn)
        package_ids = package_deps_resource.find_recent_updated_package_ids(count)
        packages = package_resource.find_by_ids(package_ids)
        return packages
      end
    end

    def update_deps(package_id, deps)
      @context.mysql.connect do |conn|
        package_deps_resource = PackageDepsResource.new(conn)
        package_deps_resource.insert_deps(
          package_id,
          compute_status(deps.dependencies),
          compute_status(deps.development_dependencies),
          deps.to_json
        )
      end
    end

    def fetch_badge_svg(dev : Bool, status : String) : String
      prefix = dev ? "dev-" : ""
      path = "#{Config::ASSETS_DIR}/img/status/#{prefix}#{status}.svg"
      File.read(path)
    end

    def fetch_badge_url(package : Entities::Rows::Package, dev : Bool)
      prefix = dev ? "dev_" : ""
      host = package.host
      owner = package.owner
      repo = package.repo
      "badge/#{host}/#{owner}/#{repo}/#{prefix}status.svg"
    end

    # https://github.com/alanshaw/david-www/blob/6ce1f5b6cbce2e7cd6f26acc95eed2d9002885cb/lib/brains.js#L332-L336
    def compute_status(dependencies)
      return "none" if dependencies.size == 0

      # unpinned
      out_of_date_count = dependencies.filter { |dep| dep.status == "out_of_date" }
      if dependencies.size.to_f / out_of_date_count > 0.25
        "out_of_date"
      elsif out_of_date_count > 0
        "not_so_up_to_date"
      else
        "up_to_date"
      end
    end
  end
end
