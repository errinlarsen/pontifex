require 'spec_helper'

module Pontifex
  describe CLI do
    describe "#new" do
      it "creates a new Pontifex::CLI instance" do
        CLI.new.should be_an_instance_of(CLI)
      end
    end
  end
end
