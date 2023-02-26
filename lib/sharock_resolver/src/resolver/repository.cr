require "shards/dependency"
require "shards/package"

require "./overrides/dependency"

module Sharock
  module Resolver
    class Repository
      property github : String?
      @name : String?

      def name : String?
        @name.try { |name| return name }
        @github.try do |github|
          github.split("/")[1]?
        end
      end

      def to_shards_dependency
        self.name.try do |name|
          dependency = Shards::Dependency.new(name)

          @github.try do |github|
            dependency["github"] = github
          end

          dependency
        end
      end

      def to_shards_package
        self.to_shards_dependency.try do |dependency|
          dependency.to_package
        end
      end
    end
  end
end
