module Sharock
  module Resolver
    class DependencyList
      getter dependencies
      getter development_dependencies

      def initialize(
                     @dependencies : Array(Dependency),
                     @development_dependencies : Array(Dependency))
      end
    end
  end
end
