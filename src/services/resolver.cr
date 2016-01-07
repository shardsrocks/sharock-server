require "../resources/db/package"
require "../resources/redis/resolver"

module Sharock::Services
  class ResolverService
    include Resources::Redis
    include Resources::DB

    def initialize(@context = Services.context)
    end

    def sync(host, owner, repo)
      @context.mysql.connect do |conn|
        package_resource = PackageResource.new(conn)
        package = package_resource.find_or_create(host, owner, repo)

        conn.transaction do
          package.try do |package|
            locked_package = package_resource.find_one_by_id(package.id, for_update: true)

            locked_package.try do |package|
              package_resource.update_sync_started_at(package.id, Time.now)

              @context.redis.connect do |redis|
                resolver_resource = ResolverResource.new(redis)
                resolver_resource.enqueue(package.id)
              end
            end
          end
        end
      end
    end
  end
end
