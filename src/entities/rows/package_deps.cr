module Sharock::Entities::Rows
  class PackageDeps
    def initialize(@id, @package_id, @version, @deps_data, @created_at)
    end

    def to_json(io : IO)
      io.json_object do |object|
        object.field "id", @id
        object.field "package_id", @package_id
        object.field "version", @version
        object.field "deps_data", @deps_data
      end
    end
  end
end
