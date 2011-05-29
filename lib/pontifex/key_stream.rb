module Pontifex 
  class KeyStream
    attr_reader :deck

    DEFAULT_KEY = "Ac,2c,3c,4c,5c,6c,7c,8c,9c,Tc,Jc,Qc,Kc," +
                  "Ad,2d,3d,4d,5d,6d,7d,8d,9d,Td,Jd,Qd,Kd," +
                  "Ah,2h,3h,4h,5h,6h,7h,8h,9h,Th,Jh,Qh,Kh," +
                  "As,2s,3s,4s,5s,6s,7s,8s,9s,Ts,Js,Qs,Ks," +
                  "ja,jb"
    JA = Card.new("ja")
    JB = Card.new("jb")

    def initialize(key=DEFAULT_KEY)
      @deck = process_param(key)
    end

    def sequence!
      move_down!("ja", 1)
      move_down!("jb", 2)
      triple_cut!
      count_cut!
    end

    def letter
      count = @deck.first.to_i
      if result = @deck[count].to_c
        result
      else
        sequence!
        letter
      end
    end

    def to_key
      @deck.map { |card| card.str }.join(",")
    end


    private
    def process_param(str)
      raise(KeyStreamArgumentError, "'key' parameter must be a string") unless str.instance_of?(String)
      key_ary = str.split(",")
      raise(KeyStreamArgumentError, "'key' parameter must contain exactly 54 'cards'") unless key_ary.count == 54
      key_ary.map { |param| Card.new(param) }
    end

    def move_down!(card_str, num)
      num.times do
        index = @deck.index { |c| c.str == card_str }
        unless @deck[index] == @deck.last
          @deck[index], @deck[index + 1] = @deck[index + 1], @deck[index]
        else
          @deck.insert(1, @deck.pop)
        end
      end
    end

    def triple_cut!
      ti, bi = @deck.index(JA), @deck.index(JB)
      ti, bi = bi, ti if ti > bi

      top = @deck[0...ti]
      middle = @deck[ti..bi]
      bottom = @deck[(bi + 1)..-1]

      @deck.replace(bottom + middle + top)
    end

    def count_cut!
      count = @deck.last.to_i
      top = @deck.shift(count)
      @deck.insert(-2, *top)
    end
  end
end
