require 'spec_helper'

module Pontifex
  describe Card do
    describe "#new" do
      describe "input validations" do
        it "should raise an error with an input parameter that is not a string" do
          expect { card = Card.new(26) }.to raise_error Pontifex::CardArgumentError, "'input_str' parameter must be a string"
        end

        it "should raise an error with an input paramter that is less than 2 characters" do
          expect { card = Card.new("5") }.to raise_error Pontifex::CardArgumentError, "'input_str' must be 2 characters long"
        end

        it "should raise an error with an input paramter that is more than 2 characters" do
          expect { card = Card.new("5As") }.to raise_error Pontifex::CardArgumentError, "'input_str' must be 2 characters long"
        end

        it "should raise an error with an input parameter outside of the letters A,T,J,Q or K and the numbers 2-9 as the first character" do
          expect { card = Card.new("bs") }.to raise_error Pontifex::CardArgumentError, "first character of 'input_str' must be one of [2-9,A,T,J,Q,K]"
        end

        it "should raise an error with an input parameter outside of the letters c,d,h,s,a,b as the second character"do
          expect { card = Card.new("9g") }.to raise_error Pontifex::CardArgumentError, "second character of 'input_str' must be one of [a,b,c,d,h,s]"
        end

        it "should raise an error with a valid card value character, but with a suit of 'a' or 'b'" do
          expect { card = Card.new("9b") }.to raise_error Pontifex::CardArgumentError, "only Jokers may have a suit of 'a' or 'b'"
        end

        it "should raise an error with an input parameter of a Joker with a suit other than 'a' or 'b'" do
          expect { card = Card.new("Jd") }.to raise_error Pontifex::CardArgumentError, "Jokers may not have a suit other than 'a' or 'b'"
        end
      end

      it "should create a card with a value of 2 if '2c' is input as a parameter" do
        card = Card.new "2c"
        card.value.should == 2
      end

      it "should create a card with a value of 25 if 'Qd' is input as a parameter" do
        card = Card.new "Qd"
        card.value.should == 25
      end

      it "should create a card with a value of 36 if 'Th' is input as a parameter" do
        card = Card.new "Th"
        card.value.should == 36
      end

      it "should create a card with a value of 40 if 'As' is input as a parameter" do
        card = Card.new "As"
        card.value.should == 40
      end

      it "should create a card with a value of 53 if 'Ja' is input as a paramter" do
        card = Card.new "Ja"
        card.value.should == 53
      end
    end
  end
end
