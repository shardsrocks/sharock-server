require "./*"

module Sharock::Services
  class AllServices
    getter package
    getter resolver

    def initialize(resources)
      @package = PackageService.new(resources.db)
      @resolver = ResolverService.new(resources)
    end
  end
end
