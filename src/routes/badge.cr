require "kemal"

require "../controllers/badge"

module Sharock::Routes
  class Badge
    include Controllers

    def self.register
      @@route = Badge.new.register
    end

    protected def initialize(
      @badge_controller = BadgeController.new
    )
    end

    def register
      get "/badge/github/:owner/:repo/status.svg" do |env|
        @badge_controller.fetch_status_svg_by_github(env)
      end

      get "/badge/github/:owner/:repo/dev_status.svg" do |env|
        @badge_controller.fetch_dev_status_svg_by_github(env)
      end
    end
  end
end
