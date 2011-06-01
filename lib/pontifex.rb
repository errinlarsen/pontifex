require 'bundler/setup'
require 'trollop'
require 'pontifex/cipher'


module Pontifex
  extend self

  def run
    parse_options!

    case @cmd
    when "encrypt"
      @output = @pontifex.encrypted
    when "decrypt"
      @output = @pontifex.decrypted
    end

    handle_output
  end


  private
  def handle_output
    if @cmd_options[:out_file]
      File.open(@cmd_options[:out_file], 'w') {|f| f.write(@output) }
      puts "Message #{@cmd}ed.  You can find the results in the file: #{@cmd_options[:out_file]}\n"
    else
      puts @output
    end
  end

  SUB_COMMANDS = %w[encrypt decrypt]

  def parse_options!
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

    key = ""
    if @cmd_options[:deck_key]
      Trollop::die "Can't find #{@cmd_options[:deck_key]} key file" unless File.exists?(@cmd_options[:deck_key])

      File.open(@cmd_options[:deck_key], "r") do |infile|
        while (line = infile.gets)
          key << line.chomp
        end
      end
    end

    if ARGV.empty?
      puts "Enter the message to encrypt."
      puts "enter 'Done' on a line by itself when you are done"
    end

    message = ""
    while input = gets
      break if input.nil? || input.chomp.downcase == "done"
      message << input.chomp
    end

    if key.empty?
      @pontifex = Cipher.new(message)
    else
      @pontifex = Cipher.new(message, key)
    end
  end
end
