module Pontifex
  class Card
  end

  class KeyStream
    attr_reader :deck

    def initialize
      @deck = Array.new(54) { Card.new }
    end
  end
end
