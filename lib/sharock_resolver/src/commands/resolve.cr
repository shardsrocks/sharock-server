require "../resolver/repository"
require "../resolver/resolver"
require "../results/dependency_list"

module Sharock::Commands
  class Resolve
    @cache_dir : String
    @output_file : String?
    @github : String?
    def initialize(cli)
      @cache_dir = cli.cache_dir
      @output_file = cli.output_file
      @github = cli.github
    end

    def run
      repository = Resolver::Repository.new
      repository.github = @github

      resolver = Resolver::Resolver.new
      resolver.resolve(repository).try do |dependency_list|
        result = Results::DependencyList.new(dependency_list)
        json_result = result.to_json

        Sharock.logger.debug json_result

        @output_file.try do |path|
          File.write(path, json_result)
        end
      end
    end

  end
end
