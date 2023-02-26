module Sharock::Entities::Rows
  class PackageDeps
    #include JSON::Serializable
    getter id
    getter package_id
    getter version
    getter status
    getter dev_status
    getter deps_data
    getter created_at

    def initialize(
      @id = 0,
      @package_id = 0,
      @version = 0_i64,
      @status = "",
      @dev_status = "",
      @deps_data ="",
      @created_at : Time | Nil = Time.utc)
    end

    def to_json(io : IO)
      JSON.build do |json|
        json.object do
          json.field "id", @id
          json.field "package_id", @package_id
          json.field "version", @version
          json.field "status", @status
          json.field "dev_status", @dev_status
          json.field "deps_data", @deps_data
        end
      end
    end
  end
end

