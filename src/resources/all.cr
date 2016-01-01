require "./inflater/*"
require "./query/*"
require "./*"

module Sharock::Resources
  class AllResources
    getter package
    getter package_deps

    def initialize(conn)
      @conn = conn
      @package = PackageResource.new(conn)
      @package_deps = PackageDepsResource.new(conn)
    end
  end
end
