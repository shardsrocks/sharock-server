module Sharock::Entities::Rows
  class Package
    getter id
    getter host
    getter owner
    getter repo
    getter created_at

    def initialize(@id, @host, @owner, @repo, @created_at)
    end

    def to_json(io : IO)
      io.json_object do |object|
        object.field "id", @id
        object.field "host", @host
        object.field "owner", @owner
        object.field "repo", @repo
      end
    end
  end
end
