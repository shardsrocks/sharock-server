module Sharock::Entities::Results
  class Package
    getter package
    getter package_deps
    getter status_url
    getter dev_status_url

    def initialize(
      @package,
      @package_deps,
      @status_url : String,
      @dev_status_url : String
    )
    end

    def to_json(io : IO)
      io.json_object do |object|
        object.field "package", @package
        object.field "package_deps", @package_deps
        object.field "status_url", @status_url
        object.field "dev_status_url", @dev_status_url
      end
    end
  end
end
