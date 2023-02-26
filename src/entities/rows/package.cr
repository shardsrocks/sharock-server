module Sharock::Entities::Rows
  class Package
    #nclude JSON::Serializable

    getter id
    getter host
    getter owner
    getter repo
    getter sync_started_at
    getter created_at

    def initialize(@id =0, @host="", @owner="", @repo="", @sync_started_at : Time | Nil = Time.utc, @created_at : Time | Nil = Time.utc)
    end

    def to_json(io : IO)
      JSON.build do |json|
        json.object do
          json.field "id", @id
          json.field "host", @host
          json.field "owner", @owner
          json.field "repo", @repo
        end
      end
    end
  end
end

