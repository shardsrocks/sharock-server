module Shards
  class Dependency
    def to_package
      package = Shards::Package.new(self, update_cache: true)
      package.requirements << self.version
      package
    end
  end
end
