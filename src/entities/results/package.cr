module Sharock::Entities::Results
  class Package
    def initialize(@package, @package_deps)
    end

    def to_json(io : IO)
      io.json_object do |object|
        object.field "package", @package
        object.field "package_deps", @package_deps
      end
    end
  end
end
