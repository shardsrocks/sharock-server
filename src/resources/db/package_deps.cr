module Sharock::Resources
  class PackageDepsResource
    include Inflater::PackageDeps
    include Query::Select

    def initialize(@conn)
    end

    def find
      inflate select(@conn, "package_deps")
    end

    def find_one_latest_version(package_id)
      params = { "package_id" => package_id }
      inflate_one MySQL::Query
        .new(%{
          SELECT *
          FROM `package_deps`
          WHERE `package_id` = :package_id
          ORDER BY `version` DESC
          LIMIT 1
        }, params)
        .run(@conn)
    end
  end
end
