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
        value = 53
      when /c/
        value += 0
      when /d/
        value += 13
      when /h/
        value += 26
      when /s/
        value += 39
      end

      value
    end
  end
end
