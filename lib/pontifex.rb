require 'bundler/setup'
require 'trollop'
require 'pontifex/cipher'


module Pontifex
  extend self
  def run
    parse_options!



    message = ""
    while input = gets
      break if input.nil? || input.chomp.downcase == "done"
      message << input.chomp
    end

    pontifex = Cipher.new(message, key)

    case @cmd
    when "encrypt"
      puts pontifex.encrypted
    when "decrypt"
      puts pontifex.decrypted
    end
  end


  private
  SUB_COMMANDS = %w[encrypt decrypt]

  def parse_options!
    if ARGV.empty?
      puts "Enter the message to encrypt."
      puts "enter 'Done' on a line by itself when you are done"
    end

    version_str = File.exist?('VERSION') ? File.read('VERSION') : ""
    Trollop::options do
      banner <<-EOS
      pontifex will encrypt, or decrypt messages.
      
      Usage:
               pontifex [options]
               pontifex encrypt [options] [file ...]
               pontifex decrypt [options] [file ...]
               where [options] are:
      EOS
      version version_str      
      stop_on SUB_COMMANDS
    end

    @cmd = ARGV.shift
    @cmd_options = case @cmd
    when "encrypt"
      Trollop::options do
        banner <<-EOS
        pontifex will encrypt messages from STDIN or from files.
        
        Usage:
                 pontifex encrypt [options] [file ...]
                 where [options] are:
        EOS
        version version_str
        opt :deck_key, "A file setting the key (a deck of cards) in a specific, initial order", :type => :string
        opt :out_file, "An output file for the encrypted message", :type => :string
      end
    when "decrypt"
      Trollop::options do
        banner <<-EOS
        pontifex will decrypt messages from STDIN or from files.
        
        Usage:
                 pontifex decrypt [options] [file ...]
                 where [options] are:
        EOS
        version version_str
        opt :deck_key, "A file setting the key (a deck of cards) in a specific, initial order", :type => :string
        opt :out_file, "An output file for the decrypted message", :type => :string
      end
    else
      Trollop::die "Either 'encrypt' or 'decrypt' must be passed as a sub-command"
    end

    puts @cmd_options

    if @cmd_options[:deck_key]
      Trollop::die "Can't find #{@cmd_options[:deck_key]} key file" unless File.exists?(@cmd_options[:deck_key])
    end
  end
end
