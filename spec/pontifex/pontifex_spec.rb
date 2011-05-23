require 'spec_helper'

module Pontifex
  describe "#new" do
    it "creates a new Pontifex::CLI instance" do
      Pontifex::CLI.new.should be_an_instance_of(CLI)
    end
  end
end
