module Sharock::Entities::Results
  class Package
    getter package
    getter package_deps
    getter status_badge_url
    getter dev_status_badge_url

    def initialize(
      @package : Sharock::Entities::Rows::Package,
      @package_deps : Sharock::Entities::Rows::PackageDeps,
      @status_badge_url : String = "",
      @dev_status_badge_url : String = ""
    )
    end

    def to_json(io : IO)
      JSON.build do |json|
        json.object do
          json.field "package", @package.to_json(io)
          json.field "package_deps", @package_deps.to_json(io)
          json.field "status_badge_url", @status_badge_url
          json.field "dev_status_badge_url", @dev_status_badge_url
        end
      end
    end
  end
end

