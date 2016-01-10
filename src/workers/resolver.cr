module Sharock::Workers
  class Resolver
    def self.run
      raise "Invalid arguments" if ARGV.size < 1
      package_id = ARGV[0].to_i

      Resolver.new(package_id).run
    end

    protected def initialize(@package_id)
    end
  end
end
