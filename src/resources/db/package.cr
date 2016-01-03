module Sharock::Resources
  class PackageResource
    include Inflater::Package
    include Query::Select

    def initialize(pool)
      @pool = pool
    end

    def find
      @pool.connect do |conn|
        inflate select(conn, "package")
      end
    end

    def find_one(id)
      @pool.connect do |conn|
        inflate_one select_by_id(conn, "package", id)
      end
    end

    def find_one(host, owner, repo)
      @pool.connect do |conn|
        inflate_one select_by_repo(conn, host, owner, repo)
      end
    end

    def find_or_create_for_update(host, owner, repo)
      @pool.connect do |conn|
        rows = select_by_repo(conn, host, owner, repo)
        if rows == [] of Entities::Rows::Package
          insert_by_repo(conn, host, owner, repo)
        end

        inflate_one select_by_repo(conn, host, owner, repo, true)
      end
    end

    protected def insert_by_repo(conn, host, owner, repo)
      params = {"host" => host, "owner" => owner, "repo" => repo}
      MySQL::Query
        .new(%{
          INSERT INTO `package` (`host`, `owner`, `repo`)
          VALUES (:host, :owner, :repo)
          ON DUPLICATE KEY UPDATE
            `host` = :host, `owner` = :owner, `repo` = :repo
        }, params)
        .run(conn)
    end

    protected def select_by_repo(conn, host, owner, repo, for_update = false)
      for_update = for_update ? "FOR UPDATE" : ""
      params = {"host" => host, "owner" => owner, "repo" => repo}
      MySQL::Query
        .new(%{
          SELECT *
          FROM `package`
          WHERE `host` = :host AND `owner` = :owner AND `repo` = :repo
          LIMIT 1
          #{for_update}
        }, params)
        .run(conn)
    end
  end
end
