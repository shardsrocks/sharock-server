module Sharock::Entities::Rows
  class PackageDeps
    getter id
    getter package_id
    getter version
    getter status
    getter dev_status
    getter deps_data
    getter created_at

    def initialize(
      @id,
      @package_id,
      @version,
      @status,
      @dev_status,
      @deps_data,
      @created_at)
    end

    def to_json(io : IO)
      io.json_object do |object|
        object.field "id", @id
        object.field "package_id", @package_id
        object.field "version", @version
        object.field "status", @status
        object.field "dev_status", @dev_status
        object.field "deps_data", @deps_data
      end
    end
  end
end
