module Sharock::Resources
  class PackageDepsResource
    include Inflater::PackageDeps
    include Query::Select

    def initialize(pool)
      @pool = pool
    end

    def find
      @pool.connect do |conn|
        inflate select(conn, "package_deps")
      end
    end

    def find_one_latest_version(package_id)
      @pool.connect do |conn|
        params = { "package_id" => package_id }
        inflate_one MySQL::Query
          .new(%{
            SELECT *
            FROM `package_deps`
            WHERE `package_id` = :package_id
            ORDER BY `version` DESC
            LIMIT 1
          }, params)
          .run(conn)
      end
    end
  end
end
