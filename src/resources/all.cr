require "./db/inflater/*"
require "./db/query/*"
require "./db/*"
require "./redis/*"

module Sharock::Resources
  class AllResources
    getter db
    getter resolver

    def initialize(@db, redis)
      @resolver = Redis::ResolverResource.new(redis)
    end

    def package(conn)
      PackageResource.new(conn)
    end

    def package_deps(conn)
      PackageDepsResource.new(conn)
    end
  end
end
