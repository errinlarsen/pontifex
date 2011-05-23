#The Solitaire Cipher (Ruby Quiz #1)
Cryptologist Bruce Schneier designed the hand cipher ["Solitaire"](http://www.schneier.com/solitaire.html)
for Neal Stephenson's book "Cryptonomicon". Created to be the first truly secure hand cipher, Solitaire
requires only a deck of cards for the encryption and decryption of messages.

While it's true that Solitaire is easily completed by hand given ample time, using a computer is much quicker
and easier. Because of that, Solitaire conversion routines are available in many languages, though I've not
yet run across one in Ruby.

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

5. Add the message numbers from step 3 to the keystream numbers from step 4 and subtract 26 from the result if it is greater than 26. For example, 6 + 10 = 16 as expected, but 26 + 1 = 1 (27 - 26):

    7 12 14 3 17  13 10 1 6 6  6 22 15 13 2  10 9 25 3 2

6. Convert the numbers from step 5 back to letters:

    GLNCQ MJAFF FVOMB JIYCB
