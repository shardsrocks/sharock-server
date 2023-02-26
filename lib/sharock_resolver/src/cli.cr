require "option_parser"
require "./commands/*"
require "./logger"

module Sharock
  class CLI
    getter :cache_dir
    getter :output_file
    getter :github

    def initialize(
                   #@cache_dir = Shards::CACHE_DIRECTORY,
                   @cache_dir = ".shards",
                   @output_file = nil.as(String?),
                   @github = nil.as(String?))
    end

    def try_run
      begin
        run
      rescue e : Exception
        abort e.message
      end
    end

    protected def run
      OptionParser.parse! do |opts|
        opts.on("--cache-dir=CACHE_DIR", "") { |x| @cache_dir = x }
        opts.on("--output-file=JSON_FILE_PATH", "") { |x| @output_file = x }
        opts.on("--github=OWNER/REPO", "") { |x| @github = x }
        opts.on("-v", "--verbose", "") { Sharock.logger.level = Logger::Severity::DEBUG }
        opts.on("-q", "--quiet", "") { Sharock.logger.level = Logger::Severity::WARN }
      end

      command = Commands::Resolve.new(self)
      command.run
    end
  end
end
