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
        package = @package_service.fetch_package(host, owner, repo)
        badge_url = @package_service.get_badge_url(dev, package)
        redirect badge_url
        return
      end

      raise "Invalid parameters"
    end
  end
end
