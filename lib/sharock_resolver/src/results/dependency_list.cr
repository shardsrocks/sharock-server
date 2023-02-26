require "json"

require "../resolver/dependency_list"
require "./dependency"

module Sharock::Results
  class DependencyList
    getter dependencies : Array(Sharock::Results::Dependency)
    getter development_dependencies : Array(Sharock::Results::Dependency)

    def initialize(@dependency_list : Resolver::DependencyList)
      @dependencies = to_results(@dependency_list.dependencies)
      @development_dependencies = to_results(@dependency_list.development_dependencies)
    end

    #def to_json(json : JSON::Builder)
    def to_json
      JSON.build do |json|
        json.object do
          json.field "dependencies", @dependencies
          json.field "developmentDependencies", @development_dependencies
        end
      end
    end

    protected def to_results(dependencies)
      dependencies.map do |dependency|
        Dependency.new(dependency)
      end
    end
  end
end
