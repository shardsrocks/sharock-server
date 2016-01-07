require "mysql"

require "./inflater/*"
require "./query/*"

module Sharock::Resources::DB
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
      inflate_one ::MySQL::Query
        .new(%{
          SELECT *
          FROM `package_deps`
          WHERE `package_id` = :package_id
          ORDER BY `version` DESC
          LIMIT 1
        }, params)
        .run(@conn)
    end

    def insert_deps(package_id, status : String, dev_status : String, deps_data : String)
      params = {
        "package_id" => package_id,
        "version" => Time.now.epoch,
        "status" => status,
        "dev_status" => dev_status,
        "deps_data" => deps_data,
      }
      ::MySQL::Query
        .new(%{
          INSERT INTO `package_deps` (`package_id`, `version`, `status`, `dev_status`, `deps_data`)
          VALUES (:package_id, :version, :status, :dev_status, :deps_data)
        }, params)
        .run(@conn)
    end
  end
end
