require "kemal"

module Sharock::Routes::API
  class Keepalive
    def self.register
      @@route = Sharock::Routes::API::Keepalive.new.register
    end

    protected def initialize
    end

    def register
      get "/api/keepalive" do |env|
        env.content_type = "text/plain"
        "OK"
      end
    end
  end
end
