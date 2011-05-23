require 'spec_helper'

module CLIAppTemplate
  describe "#new" do
    it "creates a new CLIAppTemplate::CLI instance" do
      CLIAppTemplate::CLI.new.should be_an_instance_of(CLI)
    end
  end
end
