require "./spec_helper"

module Resque::Client
  describe Job do
    describe "initialize" do
      it %{argsments = []} do
        job = Job.new("Class")
        job.job_class.should eq("Class")
        job.job_args.should eq(Tuple.new)
      end

      it %{argsments = ["foo"]} do
        job = Job.new("Class", "foo")
        job.job_class.should eq("Class")
        job.job_args.should eq({"foo"})
      end

      it %{argsments = ["foo", 1, nil]} do
        job = Job.new("Class", "foo", 1, nil)
        job.job_class.should eq("Class")
        job.job_args.should eq({"foo", 1, nil})
      end
    end

    describe "to_json" do
      it %{argsments = []} do
        job = Job.new("Class")
        job.to_json.should eq(%<{"class":"Class","args":[]}>)
      end

      it %{argsments = ["foo"]} do
        job = Job.new("Class", "foo")
        job.to_json.should eq(%<{"class":"Class","args":["foo"]}>)
      end

      it %{argsments = ["foo", 1, nil]} do
        job = Job.new("Class", "foo", 1, nil)
        job.to_json.should eq(%<{"class":"Class","args":["foo",1,null]}>)
      end
    end
  end
end
