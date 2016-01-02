module Sharock::Services
  class ResolverService
    def initialize(@resources)
    end

    def sync(host, owner, repo)
      package = @resources.package.find_or_create_for_update(host, owner, repo)
      @resources.resolver.enqueue(package.id)
    end
  end
end
