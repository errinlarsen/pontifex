require 'spec_helper'

module Pontifex
  describe KeyStream do
    describe "#new" do
      let(:key_stream) { KeyStream.new }
      it "creates a representation of a deck of cards implemented with an Array" do
        key_stream.deck.should be_an_instance_of(Array)
      end

      it "should have 54 'cards' in it" do
        key_stream.deck.count.should == 54
      end

      it "should contain nothing but Card instances" do
        expected_count = key_stream.deck.count
        key_stream.deck.select { |c| c.instance_of?(Card) }.count.should == expected_count
      end
    end
  end
end
