require 'pontifex/key_stream'

module Pontifex
  class Cipher
    def initialize(str, deck_key=nil)
      @raw = str
      @keystream = deck_key.nil? ? KeyStream.new : KeyStream.new(deck_key)
    end

    def encrypted
      @keystream.sequence!
      processed = @raw.upcase.gsub(/[^A-Z]/, "")
      processed << "X" * (5 - (processed.length % 5)) unless (processed.length % 5) == 0

      results = ""
      processed.each_char do |c|
        k = @keystream.letter
        value = (c.ord - 64) + (k.ord - 64)
        results << ((value > 26 ? value - 26 : value) + 64).chr
        @keystream.sequence!
      end

      output_str = ""
      results.scan(/.{5}/).each_slice(5) { |s| output_str << s.join(" ") + "\n" }
      output_str.chomp
    end

    def decrypted
      @keystream.sequence!
      processed = @raw.upcase.gsub(/[^A-Z]/, "")

      results = ""
      processed.each_char do |c|
        k = @keystream.letter
        if (c.ord - 64) <= (k.ord - 64)
          value = (c.ord - 64 + 26) - (k.ord - 64)
        else
          value = (c.ord - 64) - (k.ord - 64)
        end
        results << (value + 64).chr
        @keystream.sequence!
      end

      output_str = ""
      results.scan(/.{5}/).each_slice(5) { |s| output_str << s.join(" ") + "\n" }
      output_str.chomp
    end
  end
end
