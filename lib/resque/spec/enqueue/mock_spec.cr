require "../spec_helper"

class RedisMock
  getter queue
  getter arg

  def rpush(queue : String, arg : String)
    @queue = queue
    @arg = arg
  end
end

module Resque::Client
  describe Enqueuer do
    describe "enqueue" do
      it "mock" do
        redis = RedisMock.new
        enqueuer = Enqueuer.new(redis)

        enqueuer.enqueue("queue", "Class", "foo", 1, nil)

        redis.queue.should eq("queue")
        redis.arg.should eq(%<{"class":"Class","args":["foo",1,null]}>)
      end
    end
  end
end
