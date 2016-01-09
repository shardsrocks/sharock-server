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
      in_query = ids.map_with_index { |v, i| ":id_#{i}" }.join(",")
      in_params = ids.map_with_index { |v, i| {"id_#{i}",v} }.to_h
      in_params["limit"] = ids.size
      ::MySQL::Query
        .new(%{
          SELECT *
          FROM `#{table}`
          WHERE `id` IN(#{in_query})
          LIMIT :limit
          #{for_update ? "FOR UPDATE" : ""}
        }, in_params)
        .run(conn)
    end
  end
end
