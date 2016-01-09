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

    def update_deps(package_id, deps)
      @context.mysql.connect do |conn|
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

    def fetch_badge_svg(dev : Bool, status : String) : String
      prefix = dev ? "dev-" : ""
      path = "#{Config::ASSETS_DIR}/img/status/#{prefix}#{status}.svg"
      File.read(path)
    end

    def fetch_badge_url(package : Entities::Rows::Package, dev : Bool)
      prefix = dev ? "dev-" : ""
      host = package.host
      owner = package.owner
      repo = package.repo
      "/badge/#{host}/#{owner}/#{repo}/#{prefix}status.svg"
    end
  end
end
