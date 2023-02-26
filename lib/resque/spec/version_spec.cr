require "./spec_helper"

module Resque
  describe Resque do
    it "VERSION" do
      Client::VERSION.should be_a(String)
    end
  end
end
