require "../resources/db/package"
require "../resources/redis/resolver"

module Sharock::Services
  class ResolverService
    include Resources::Redis
    include Resources::DB

    def initialize(@context = Services.context)
    end

    def sync_if_needs(host, owner, repo)
      @context.mysql.connect do |conn|
        package_resource = PackageResource.new(conn)
        package = package_resource.find_or_create(host, owner, repo)
        package.try do |package|
          return unless needs_syncing(package)
        end

        conn.transaction do
          package.try do |package|
            return unless needs_syncing(package)
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

    def needs_syncing(package : Entities::Rows::Package)
      package.try do |package|
        package.sync_started_at.try do |sync_started_at|
          span = Time.now - sync_started_at
          return span.seconds > Config::CACHE_TIME_SEC
        end

        return true
      end

      return true
    end
  end
end
