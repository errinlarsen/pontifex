module Pontifex 
  class Card
    attr_reader :str

    def initialize(input_str)
      @str = input_str
      @value = process_input(input_str)
    end

    def to_i
      @value
    end

    def to_c
      return nil if str[0] == "j"
      letters = "ABCDEFGHIJKLMNOPQRSTUVWXYZ".split('')
      letters[(@value % 26) - 1]
    end

    def ==(other)
      self.str == other.str
    end


    private
    def process_input(str)
      raise(ArgumentError, "Cards must be 2 characters long") unless str.length == 2
      raise(ArgumentError, "first character of a card must be one of [2-9,j,A,T,J,Q,K]") unless str[0] =~ /[2-9,j,A,T,J,Q,K]/
      raise(ArgumentError, "second character of a card must be one of [a,b,c,d,h,s]") unless str[1] =~ /[a,b,c,d,h,s]/

      value = 0
      case str[0]
      when /[2-9]/
        value += str[0].to_i
      when /j/
        value = 0
      when /A/
        value = 1
      when /T/
        value = 10
      when /J/
        value = 11
      when /Q/
        value = 12
      when /K/
        value = 13
      end

      case str[1]
      when /[a,b]/
        raise(ArgumentError, "only Jokers may have a suit of 'a' or 'b'") unless str[0] == "j"
        value = 53
      when /c/
        raise(ArgumentError, "Jokers may not have a suit other than 'a' or 'b'") if str[0] == "j"
        value += 0
      when /d/
        raise(ArgumentError, "Jokers may not have a suit other than 'a' or 'b'") if str[0] == "j"
        value += 13
      when /h/
        raise(ArgumentError, "Jokers may not have a suit other than 'a' or 'b'") if str[0] == "j"
        value += 26
      when /s/
        raise(ArgumentError, "Jokers may not have a suit other than 'a' or 'b'") if str[0] == "j"
        value += 39
      end

      value
    end
  end
end
