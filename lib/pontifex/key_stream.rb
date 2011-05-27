module Pontifex 
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
      raise(KeyStreamArgumentError, "'key' parameter must be a string") unless str.instance_of?(String)
      key_ary = str.split(",")
      raise(KeyStreamArgumentError, "'key' parameter must contain exactly 54 'cards'") unless key_ary.count == 54
      key_ary.map { |param| Card.new(param) }
    end
  end
end
