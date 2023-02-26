require "sharock_resolver/resolver/repository"
require "sharock_resolver/resolver/resolver"
require "sharock_resolver/results/dependency_list"

require "../services/package"

module Sharock::Workers
  class Resolver
    include Sharock::Services

    def self.run
      raise "Invalid arguments" if ARGV.size < 1
      package_id = ARGV[0].to_i

      Resolver.new.run(package_id)
    end

    protected def initialize(
      @package_service = PackageService.new
    )
    end

    def run(package_id)
      package = @package_service.fetch_package_by_id(package_id)
      raise "Package is not found (id = #{package_id})" unless package

      repository = Sharock::Resolver::Repository.new
      repository.github = "#{package.owner}/#{package.repo}"

      resolver = Sharock::Resolver::Resolver.new
      resolver.resolve(repository).try do |dependency_list|
        result = Results::DependencyList.new(dependency_list)
        puts result.to_json
        @package_service.update_deps(package.id, result)
      end
    end
  end
end
