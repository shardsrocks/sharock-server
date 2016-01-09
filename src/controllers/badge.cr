require "../services/package"

module Sharock::Controllers
  class BadgeController
    include Services

    def initialize(
      @package_service = PackageService.new
    )
    end

    def fetch_status_svg_by_github(env)
      fetch_status_svg(env, false, "github")
    end

    def fetch_dev_status_svg_by_github(env)
      fetch_status_svg(env, true, "github")
    end

    protected def fetch_status_svg(env, dev, host)
      owner = env.params["owner"]
      repo = env.params["repo"]

      if owner.is_a? String && repo.is_a? String
        result = @package_service.fetch_package(host, owner, repo)
        result.try do |result|
          status = dev ? result.package_deps.dev_status : result.package_deps.status
          badge_svg = @package_service.fetch_badge_svg(dev, status)
          env.content_type = "image/svg+xml"
          return badge_svg
        end
      end

      raise "Invalid parameters"
    end
  end
end
