require "shards/resolvers/github"
require "shards/resolvers/path"
require "shards/resolvers/git"
require "shards/resolvers/resolver"
require "shards/config"
require "shards/dependency"
require "shards/logger"
require "shards/package"
require "shards/spec"

require "./overrides/resolvers/resolver"
require "./overrides/dependency"
require "./overrides/package"
require "./dependency"
require "./dependency_list"

module Sharock
  module Resolver
    class Resolver
      def resolve(repository : Repository)
        repository.to_shards_package.try do |package|
          resolver = package.resolver
          spec = resolver.spec

          DependencyList.new(
            resolve(spec.dependencies),
            resolve(spec.development_dependencies)
          )
        end
      end

      protected def resolve(dependencies : Array(Shards::Dependency))
        dependencies.map do |dependency|
          package = dependency.to_package
          package.spec
          Dependency.new(dependency, package)
        end
      end
    end
  end
end
