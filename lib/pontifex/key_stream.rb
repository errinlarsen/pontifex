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
      letters = "abcdefghijklmnopqrstuvwxyz".split('')
      letters[(@value % 26) - 1]
    end

    def ==(other)
      self.str == other.str
    end


    private
    def process_input(str)
      raise(CardArgumentError, "'input_str' parameter must be a string") unless str.instance_of?(String)
      raise(CardArgumentError, "'input_str' must be 2 characters long") unless str.length == 2
      raise(CardArgumentError, "first character of 'input_str' must be one of [2-9,j,A,T,J,Q,K]") unless str[0] =~ /[2-9,j,A,T,J,Q,K]/
      raise(CardArgumentError, "second character of 'input_str' must be one of [a,b,c,d,h,s]") unless str[1] =~ /[a,b,c,d,h,s]/

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
        raise(CardArgumentError, "only Jokers may have a suit of 'a' or 'b'") unless str[0] == "j"
        value = 53
      when /c/
        raise(CardArgumentError, "Jokers may not have a suit other than 'a' or 'b'") if str[0] == "j"
        value += 0
      when /d/
        raise(CardArgumentError, "Jokers may not have a suit other than 'a' or 'b'") if str[0] == "j"
        value += 13
      when /h/
        raise(CardArgumentError, "Jokers may not have a suit other than 'a' or 'b'") if str[0] == "j"
        value += 26
      when /s/
        raise(CardArgumentError, "Jokers may not have a suit other than 'a' or 'b'") if str[0] == "j"
        value += 39
      end

      value
    end
  end

  class KeyStream
    attr_reader :deck

    DEFAULT_KEY = "Ac,2c,3c,4c,5c,6c,7c,8c,9c,Tc,Jc,Qc,Kc," +
                  "Ad,2d,3d,4d,5d,6d,7d,8d,9d,Td,Jd,Qd,Kd," +
                  "Ah,2h,3h,4h,5h,6h,7h,8h,9h,Th,Jh,Qh,Kh," +
                  "As,2s,3s,4s,5s,6s,7s,8s,9s,Ts,Js,Qs,Ks," +
                  "ja,jb"

    def initialize(key=DEFAULT_KEY)
      @deck = process_param(key)
    end

    private
    def process_param(str)
      str.split(",").map { |param| Card.new(param) }
    end
  end
end
