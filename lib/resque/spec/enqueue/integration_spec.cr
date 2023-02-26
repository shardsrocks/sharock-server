require "redis"
require "../spec_helper"

module Resque::Client
  describe Enqueuer do
    describe "enqueue" do
      it "integration" do
        redis = Redis.new
        enqueuer = Enqueuer.new(redis)

        redis.del("queue")

        enqueuer.enqueue("queue", "Class")
        enqueuer.enqueue("queue", "Class", "foo", 1, nil)

        redis.lrange("queue", 0, 1).should eq([
          %<{"class":"Class","args":[]}>,
          %<{"class":"Class","args":["foo",1,null]}>,
        ])
      end
    end
  end
end
