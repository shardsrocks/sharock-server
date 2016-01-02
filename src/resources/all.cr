require "./db/inflater/*"
require "./db/query/*"
require "./db/*"
require "./redis/*"

module Sharock::Resources
  class AllResources
    getter package
    getter package_deps
    getter resolver

    def initialize(db, redis)
      @package = PackageResource.new(db)
      @package_deps = PackageDepsResource.new(db)
      @resolver = Redis::ResolverResource.new(redis)
    end
  end
end
