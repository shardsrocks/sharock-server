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

    def select_by_ids(conn, table, ids, for_update = false)
      ids_query = ids.map_with_index { |v, i| ":id_#{i}" }.join(",")
      params = ids.map_with_index { |v, i| {"id_#{i}",v} }.to_h
      params["limit"] = ids.size
      ::MySQL::Query
        .new(%{
          SELECT *
          FROM `#{table}`
          WHERE `id` IN(#{ids_query})
          ORDER BY FIELD(`id`, #{ids_query})
          LIMIT :limit
          #{for_update ? "FOR UPDATE" : ""}
        }, params)
        .run(conn)
    end
  end
end
