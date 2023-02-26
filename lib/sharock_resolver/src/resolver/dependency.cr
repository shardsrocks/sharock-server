module Sharock
  module Resolver
    class Dependency
      getter package
      getter dependency

      def initialize(
                     @dependency : Shards::Dependency,
                     @package : Shards::Package)
      end
    end
  end
end
