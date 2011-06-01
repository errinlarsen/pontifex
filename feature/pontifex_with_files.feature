Feature: Pontifex (Solitaire) cipher

  As a spy sending a secret message
  I want to utilize a cipher
  So that I can encrypt my message

  Scenario: Encrypting a message file with Pontifex
    Given a file named "message_to_encrypt.txt" with:
      """
      Code in Ruby, live longer!"
      """
    When I run `pontifex encrypt message_to_encrypt.txt`
    Then the output should contain:
      """
      GLNCQ MJAFF FVOMB JIYCB
      """

  Scenario: Decrypting a message file with Pontifex
    Given a file named "message_to_decrypt.txt" with:
      """
      GLNCQ MJAFF FVOMB JIYCB
      """
    When I run `pontifex decrypt message_to_decrypt.txt`
    Then the output should contain:
      """
      CODEI NRUBY LIVEL ONGER
      """

  Scenario: One
    Given a file named "set_deck.key" with:
      """
      Ac,2c,3c,4c,5c,6c,7c,8c,9c,Tc,Jc,Qc,Kc,
      Ad,2d,3d,4d,5d,6d,7d,8d,9d,Td,Jd,Qd,Kd,
      Ah,2h,3h,4h,5h,6h,7h,8h,9h,Th,Jh,Qh,Kh,
      As,2s,3s,4s,5s,6s,7s,8s,9s,Ts,Js,Qs,Ks,
      ja,jb
      """
    And a file named "message_to_encrypt.txt" with:
      """
      Code in Ruby, live longer!"
      """
    When I run `pontifex encrypt -d set_deck.key -o encrypted_message.txt message_to_encrypt.txt`
    Then the output should contain:
      """
      Message encrypted.  You can find the results in the file: encrypted_message.txt
      """
    And the file "encrypted_message.txt" should contain exactly:
      """
      GLNCQ MJAFF FVOMB JIYCB
      """

  Scenario: Two
    Given a file named "set_deck.key" with:
      """
      Ac,2c,3c,4c,5c,6c,7c,8c,9c,Tc,Jc,Qc,Kc,
      Ad,2d,3d,4d,5d,6d,7d,8d,9d,Td,Jd,Qd,Kd,
      Ah,2h,3h,4h,5h,6h,7h,8h,9h,Th,Jh,Qh,Kh,
      As,2s,3s,4s,5s,6s,7s,8s,9s,Ts,Js,Qs,Ks,
      ja,jb
      """
    And a file named "message_to_decrypt.txt" with:
      """
      GLNCQ MJAFF FVOMB JIYCB
      """
    When I run `pontifex decrypt -d set_deck.key -o decrypted_message.txt message_to_decrypt.txt`
    Then the output should contain:
      """
      Message decrypted.  You can find the results in the file: decrypted_message.txt
      """
    And the file "decrypted_message.txt" should contain exactly:
      """
      CODEI NRUBY LIVEL ONGER
      """
