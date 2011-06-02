# Pontifex: a Solitaire Cipher implementation

Pontifex provides a CLI interface to encrypt and decrypt messages utilizing [The Solitaire Ciphear](http://www.schneier.com/solitaire.html) as designed by Bruce Schneier and featured in Neal Stephenson's +Cryptonomicon+.

This implementation was developed as a solution to [Ruby Quiz #1](http://www.rubyquiz.com/quiz1.html)

## Pontifex

Use RubyGems to install pontifex:

    $ gem install pontifex

Once pontifex is installed, you can use it by passing it one of two subcommands: `encrypt` or `decrypt`

    $ pontifex encrypt
    Enter the message to encrypt.
    enter 'Done' on a line by itself when you are done

At this point, type your message into `STDIN`.  On a line by itself, enter 'done' to signal that your message is complete.

Your encrypted message will be output to the `STDOUT`.

## Key files

The Solitaire Cipher requires a keyed deck of cards.  By default, the cipher will use a deck of cards ordered Ace to King, suites clubs thru spades, with the two jokers on the bottom of the deck.

If you'd like to key the deck in a different way (and you do), pass the `-d` option to pontifex and the name of the key file.  This file should have the 54 cards, seperated by commas, in the order you prefer.

    $ cat some_other.key
    Ad,2d,3d,4d,5d,6d,7d,8d,9d,Td,Jd,Qd,Kd,
    Ac,2c,3c,4c,5c,6c,7c,8c,9c,Tc,Jc,Qc,Kc,ja,
    Ah,2h,3h,4h,5h,6h,7h,8h,9h,Th,Jh,Qh,Kh,jb,
    As,2s,3s,4s,5s,6s,7s,8s,9s,Ts,Js,Qs,Ks

    $ pontifex encrypt -d some_other.key

## Output files

If you'd like to output your encrypted or decrypted message to a file, just pass the `-o` option and a file name.

    $ pontifex encrypt -o encrypted_message.txt

This option and the `-d` option can (and should) be combined.

## Input files

Any files listed on the command line after the above options will be concatenated and will be considered input for whichever sub-command requested.  This will turn off input via STDIN.

    $ pontifex encrypt -d some_other.key -o encrypted_results.txt message_to_be_encrypted.txt [...]

## Copyright

Copyright (c) 2008-2010 Errin Larsen. See LICENSE for details.
