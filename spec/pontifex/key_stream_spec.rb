require 'spec_helper'

module Pontifex
  describe KeyStream do
    let(:default_key) do
      key = "Ac,2c,3c,4c,5c,6c,7c,8c,9c,Tc,Jc,Qc,Kc," +
        "Ad,2d,3d,4d,5d,6d,7d,8d,9d,Td,Jd,Qd,Kd," +
        "Ah,2h,3h,4h,5h,6h,7h,8h,9h,Th,Jh,Qh,Kh," +
        "As,2s,3s,4s,5s,6s,7s,8s,9s,Ts,Js,Qs,Ks," +
        "ja,jb"
    end
    let(:key_stream) { KeyStream.new(default_key) }

    describe "#new" do
      it "should create a standard ordered deck by default" do
        KeyStream.new.deck.should == default_key.split(",").map { |k| Card.new(k) }
      end

      describe "Parameter validation" do
        it "should raise an error with an input parameter that is not a string" do
          ary = default_key.split(",").map { |str| Card.new(str) }
          expect { KeyStream.new(ary) }.to raise_error KeyStreamArgumentError, "'key' parameter must be a string"
        end

        it "should raise an error with less than 54 'cards' in the input parameter string" do
          bad_key = default_key.split(",")[1..-2].join(",")
          expect { KeyStream.new(bad_key) }.to raise_error KeyStreamArgumentError, "'key' parameter must contain exactly 54 'cards'"
        end
      end
    end

    describe "#deck" do
      it "should return a representation of a deck of cards implemented with an Array" do
        key_stream.deck.should be_an_instance_of(Array)
      end

      it "should contain nothing but Card instances" do
        expected_count = key_stream.deck.count
        key_stream.deck.select { |c| c.instance_of?(Card) }.count.should == expected_count
      end

      it "should only contain each card once" do
        expected_count = key_stream.deck.count
        key_stream.deck.uniq.count.should == expected_count
      end
    end
  end
end
