module Sharock::Resources::Query
  module Select
    def select(table)
      @conn.query(%{ SELECT * FROM `#{table}` })
    end

    def select_by_id(table, id)
      MySQL::Query
        .new(%{ SELECT * FROM `#{table}` WHERE `id` = :id LIMIT 1 }, {"id" => id})
        .run(@conn)
    end
  end
end
