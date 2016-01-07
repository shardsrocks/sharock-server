require "mysql"

module Sharock::Resources::DB::Query
  module Select
    def select(conn, table)
      conn.query(%{ SELECT * FROM `#{table}` })
    end

    def select_by_id(conn, table, id, for_update = false)
      ::MySQL::Query
        .new(%{
          SELECT *
          FROM `#{table}`
          WHERE `id` = :id
          LIMIT 1
          #{for_update ? "FOR UPDATE" : ""}
        }, {"id" => id})
        .run(conn)
    end
  end
end
