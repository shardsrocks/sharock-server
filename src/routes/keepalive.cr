require "kemal"

module Sharock::Routes
  class Keepalive
    def self.register
      @@route = Keepalive.new.register
    end

    protected def initialize
    end

    def register
      get "/" do |env|
        env.content_type = "text/plain"
        "Hello Sharock"
      end

      get "/keepalive" do |env|
        env.content_type = "text/plain"
        "OK"
      end
    end
  end
end
