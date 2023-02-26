require "json"

module Resque::Client
  class Job
    getter job_class
    getter job_args

    def initialize(@job_class : String, *@job_args)
    end

    def to_json(io : IO)
      io.json_object do |object|
        object.field "class", @job_class
        object.field "args", @job_args
      end
    end
  end
end
