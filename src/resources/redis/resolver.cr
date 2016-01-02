require "resque_client"

module Sharock::Resources::Redis
  class ResolverResource
    RESQUE_QUEUE_NAME = "resque:queue:sharock"
    RESQUE_CLASS_NAME = "Resolve"

    def initialize(@redis)
      @queue = Resque::Client::Enqueuer.new(@redis)
    end

    def enqueue(package_id)
      @queue.enqueue(RESQUE_QUEUE_NAME, RESQUE_CLASS_NAME, package_id)
    end
  end
end
