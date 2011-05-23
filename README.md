# The Solitaire Cipher (Ruby Quiz #1)
Cryptologist Bruce Schneier designed the hand cipher ["Solitaire"](http://www.schneier.com/solitaire.html)
for Neal Stephenson's book "Cryptonomicon". Created to be the first truly secure hand cipher, Solitaire
requires only a deck of cards for the encryption and decryption of messages.

While it's true that Solitaire is easily completed by hand given ample time, using a computer is much quicker
and easier. Because of that, Solitaire conversion routines are available in many languages, though I've not
yet run across one in Ruby.  (originally published [HERE](http://rubyquiz.com/quiz1.html) in the pages of the Ruby Quiz, by James Edward Gray II)

This week's quiz is to write a Ruby script that does the encryption and decryption of messages using the
Solitaire cipher.

## Encryption
Let's look at the steps of encrypting a message with Solitaire.

1. Discard any non A to Z characters, and uppercase all remaining letters. Split the message into
   five character groups, using Xs to pad the last group, if needed. If we begin with the message "Code in Ruby,
   live longer!", for example, we would now have:

        CODEI NRUBY LIVEL ONGER

2. Use Solitaire to generate a keystream letter for each letter in the message. This step is detailed below,
   but for the sake of example let's just say we get:

        DWJXH YRFDG TMSHP UURXJ

3. Convert the message from step 1 into numbers, A = 1, B = 2, etc:

        3 15 4 5 9  14 18 21 2 25  12 9 22 5 12  15 14 7 5 18

4. Convert the keystream letters from step 2 using the same method:

        4 23 10 24 8  25 18 6 4 7  20 13 19 8 16  21 21 18 24 10

5. Add the message numbers from step 3 to the keystream numbers from step 4 and subtract 26 from the result
   if it is greater than 26. For example, 6 + 10 = 16 as expected, but 26 + 1 = 1 (27 - 26):

        7 12 14 3 17  13 10 1 6 6  6 22 15 13 2  10 9 25 3 2

6. Convert the numbers from step 5 back to letters:

        GLNCQ MJAFF FVOMB JIYCB

## Decryption
We'll work backwards with our example now, decrypting "GLNCQ MJAFF FVOMB JIYCB".

1. Use Solitaire to generate a keystream letter for each letter in the message to be decoded.
   Again, I detail this process below, but sender and receiver use the same key and will get the same letters:

        DWJXH YRFDG TMSHP UURXJ

2. Convert the message to be decoded to numbers:

        7 12 14 3 17  13 10 1 6 6  6 22 15 13 2  10 9 25 3 2

3. Convert the keystream letters from step 1 to numbers:

        4 23 10 24 8  25 18 6 4 7  20 13 19 8 16  21 21 18 24 10

4. Subtract the keystream numbers from step 3 from the message numbers from step 2. If the message number
   is less than or equal to the keystream number, add 26 to the message number before subtracting. For
   example, 22 - 1 = 21 as expected, but 1 - 22 = 5 (27 - 22):

        3 15 4 5 9  14 18 21 2 25  12 9 22 5 12  15 14 7 5 18

5. Convert the numbers from step 4 back to letters:

        CODEI NRUBY LIVEL ONGER

Transforming messages is that simple.

# Keystreaming
Finally, let's look at the missing piece of the puzzle, generating the keystream letters.

First, let's talk a little about the deck of cards. Solitaire needs a full deck of 52 cards and the
two jokers. The jokers need to be visually distinct and I'll refer to them below as A and B. Some steps
involve assigning a value to the cards. In those cases, use the cards face value as a base, Ace = 1, 2 = 2...
10 = 10, Jack = 11, Queen = 12, King = 13. Then modify the base by the bridge ordering of suits, Clubs
is simply the base value, Diamonds is base value + 13, Hearts is base value + 26, and Spades is
base value + 39. Either joker values at 53. When the cards must represent a letter Clubs and Diamonds
values are taken to be the number of the letter (1 to 26), as are Hearts and Spades after subtracting 26
from their value (27 to 52 drops to 1 to 26). Now let's make sense of all that by putting it to use.

1. Key the deck. This is the critical step in the actual operation of the cipher and the heart of it's
   security. There are many methods to go about this, such as shuffling a deck and then arranging the
   receiving deck in the same order or tracking a bridge column in the paper and using that to order the
   cards. Because we want to be able to test our answers though, we'll use an unkeyed deck, cards in order
   of value. That is, from top to bottom, we'll always start with the deck:

        Ace of Clubs
        ...to...
        King of Clubs
        Ace of Diamonds
        ...to...
        King of Diamonds
        Ace of Hearts
        ...to...
        King of Hearts
        Ace of Spades
        ...to...
        King of Spades
        "A" Joker
        "B" Joker

2. Move the A joker down one card. If the joker is at the bottom of the deck, move it to just below the
   first card. (Consider the deck to be circular.) The first time we do this, the deck will go from:

        1 2 3 ... 52 A B

    To:

        1 2 3 ... 52 B A

3. Move the B joker down two cards. If the joker is the bottom card, move it just below the second card.
   If the joker is the just above the bottom card, move it below the top card. (Again, consider the deck to
   be circular.) This changes our example deck to:

        1 B 2 3 4 ... 52 A

4. Perform a triple cut around the two jokers. All cards above the top joker move to below the bottom joker
   and vice versa. The jokers and the cards between them do not move. This gives us:

        B 2 3 4 ... 52 A 1

5. Perform a count cut using the value of the bottom card. Cut the bottom card's value in cards off the top of
   the deck and reinsert them just above the bottom card. This changes our deck to:

        2 3 4 ... 52 A B 1  (the 1 tells us to move just the B)

6. Find the output letter. Convert the top card to it's value and count down that many cards from the top of
   the deck, with the top card itself being card number one. Look at the card immediately after your count
   and convert it to a letter. This is the next letter in the keystream. If the output card is a joker, no
   letter is generated this sequence. This step does not alter the deck. For our example, the output letter is:

        D  (the 2 tells us to count down to the 4, which is a D)

7. Return to step 2, if more letters are needed.
