require 'spec_helper'

module Pontifex
  describe Card do
    describe "#new" do
      describe "input validations" do
        it "should raise an error with an input parameter that is not a string" do
          expect { Card.new(26) }.to raise_error Pontifex::CardArgumentError, "'input_str' parameter must be a string"
        end

        it "should raise an error with an input paramter that is less than 2 characters" do
          expect { Card.new("5") }.to raise_error Pontifex::CardArgumentError, "'input_str' must be 2 characters long"
        end

        it "should raise an error with an input paramter that is more than 2 characters" do
          expect { Card.new("5As") }.to raise_error Pontifex::CardArgumentError, "'input_str' must be 2 characters long"
        end

        it "should raise an error with an input parameter outside of the letters j,A,T,J,Q or K and the numbers 2-9 as the first character" do
          expect { Card.new("bs") }.to raise_error Pontifex::CardArgumentError, "first character of 'input_str' must be one of [2-9,j,A,T,J,Q,K]"
        end

        it "should raise an error with an input parameter outside of the letters c,d,h,s,a,b as the second character"do
          expect { Card.new("9g") }.to raise_error Pontifex::CardArgumentError, "second character of 'input_str' must be one of [a,b,c,d,h,s]"
        end

        it "should raise an error with a valid card value character, but with a suit of 'a' or 'b'" do
          expect { Card.new("9b") }.to raise_error Pontifex::CardArgumentError, "only Jokers may have a suit of 'a' or 'b'"
        end

        it "should raise an error with an input parameter of a Joker with a suit other than 'a' or 'b'" do
          expect { Card.new("jd") }.to raise_error Pontifex::CardArgumentError, "Jokers may not have a suit other than 'a' or 'b'"
        end
      end

      describe "Card integer values" do
        it "should create a card with a value of 2 if '2c' is input as a parameter" do
          Card.new("2c").to_i.should == 2
        end

        it "should create a card with a value of 25 if 'Qd' is input as a parameter" do
          Card.new("Qd").to_i.should == 25
        end

        it "should create a card with a value of 36 if 'Th' is input as a parameter" do
          Card.new("Th").to_i.should == 36
        end

        it "should create a card with a value of 40 if 'As' is input as a parameter" do
          Card.new("As").to_i.should == 40
        end

        it "should create a card with a value of 53 if 'ja' is input as a paramter" do
          Card.new("ja").to_i.should == 53
        end
      end

      describe "Card letter values" do
        it "should create a card with a letter of 'd' if '4c' is input as a parameter" do
          Card.new("4c").to_c.should == "D"
        end

        it "should create a card with a letter of 'u' if 'Jd' is input as a parameter" do
          Card.new("Jd").to_c.should == "X"
        end

        it "should create a card with a letter of 'j' if 'Th' is input as a parameter" do
          Card.new("Th").to_c.should == "J"
        end

        it "should create a card with a letter of 'x' if 'Js' is input as a parameter" do
          Card.new("Js").to_c.should == "X"
        end

        it "should create a card with a letter of NIL if 'Jb' is input as a paramter" do
          Card.new("jb").to_c.should be_nil
        end
      end

      describe "Equality" do
        it "should be equal to another card created with the same input as a parameter" do
          param = "Qh"
          Card.new(param).should == Card.new(param)
        end
      end
    end
  end
end
