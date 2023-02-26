require "./job"

module Resque::Client
  class Enqueuer
    getter redis

    def initialize(@redis)
    end

    def enqueue(queue : String, job_class : String, *args)
      job = Job.new(job_class, *args)
      @redis.rpush(queue, job.to_json)
    end
  end
end
