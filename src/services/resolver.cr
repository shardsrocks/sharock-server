module Sharock::Services
  class ResolverService
    def initialize(@resources)
    end

    def sync(host, owner, repo)
      @resources.db.connect do |conn|
        package_resource = @resources.package(conn)
        package = package_resource.find_or_create(host, owner, repo)

        conn.transaction do
          package.try do |package|
            locked_package = package_resource.find_one_by_id(package.id, for_update: true)
            locked_package.try do |package|
              package_resource.update_sync_started_at(package.id, Time.now)
              @resources.resolver.enqueue(package.id)
            end
          end
        end
      end
    end
  end
end
