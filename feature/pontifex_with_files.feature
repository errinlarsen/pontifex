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

  Scenario: Encrypting a message file with an alternate deck key
    Given a file named "alternate_deck.key" with:
      """
      Ah,2h,3h,4h,5h,6h,7h,8h,9h,Th,Jh,Qh,Kh,
      Ac,2c,3c,4c,5c,6c,7c,8c,9c,Tc,Jc,Qc,Kc,ja,
      As,2s,3s,4s,5s,6s,7s,8s,9s,Ts,Js,Qs,Ks,jb,
      Ad,2d,3d,4d,5d,6d,7d,8d,9d,Td,Jd,Qd,Kd,
      """
    And a file named "message_to_encrypt.txt" with:
      """
      Code in Ruby, live longer!"
      """
    When I run `pontifex encrypt -d alternate_deck.key message_to_encrypt.txt`
    Then the output should contain:
      """
      ESBMY NTMCT BVTNL NJWDN
      """

  Scenario: Decrypting a message file with an alternate deck key
    Given a file named "alternate_deck.key" with:
      """
      Ah,2h,3h,4h,5h,6h,7h,8h,9h,Th,Jh,Qh,Kh,
      Ac,2c,3c,4c,5c,6c,7c,8c,9c,Tc,Jc,Qc,Kc,ja,
      As,2s,3s,4s,5s,6s,7s,8s,9s,Ts,Js,Qs,Ks,jb,
      Ad,2d,3d,4d,5d,6d,7d,8d,9d,Td,Jd,Qd,Kd,
      """
    And a file named "message_to_decrypt.txt" with:
      """
      ESBMY NTMCT BVTNL NJWDN
      """
    When I run `pontifex decrypt -d alternate_deck.key message_to_decrypt.txt`
    Then the output should contain:
      """
      CODEI NRUBY LIVEL ONGER
      """

  Scenario: Encrypting a message file with an output file
    Given a file named "message_to_encrypt.txt" with:
      """
      Code in Ruby, live longer!"
      """
    When I run `pontifex encrypt -o encrypted_message.txt message_to_encrypt.txt`
    Then the output should contain:
      """
      Message encrypted.  You can find the results in the file: encrypted_message.txt
      """
    And the file "encrypted_message.txt" should contain exactly:
      """
      GLNCQ MJAFF FVOMB JIYCB
      """

  Scenario: Decrypting a message file with an output file
    Given a file named "message_to_decrypt.txt" with:
      """
      GLNCQ MJAFF FVOMB JIYCB
      """
    When I run `pontifex decrypt -o decrypted_message.txt message_to_decrypt.txt`
    Then the output should contain:
      """
      Message decrypted.  You can find the results in the file: decrypted_message.txt
      """
    And the file "decrypted_message.txt" should contain exactly:
      """
      CODEI NRUBY LIVEL ONGER
      """

  Scenario: Encrypting a message file with an alternate deck key and an output file
    Given a file named "alternate_deck.key" with:
      """
      Ah,2h,3h,4h,5h,6h,7h,8h,9h,Th,Jh,Qh,Kh,
      Ac,2c,3c,4c,5c,6c,7c,8c,9c,Tc,Jc,Qc,Kc,ja,
      As,2s,3s,4s,5s,6s,7s,8s,9s,Ts,Js,Qs,Ks,jb,
      Ad,2d,3d,4d,5d,6d,7d,8d,9d,Td,Jd,Qd,Kd,
      """
    And a file named "message_to_encrypt.txt" with:
      """
      Code in Ruby, live longer!"
      """
    When I run `pontifex encrypt -d alternate_deck.key -o encrypted_message.txt message_to_encrypt.txt`
    Then the output should contain:
      """
      Message encrypted.  You can find the results in the file: encrypted_message.txt
      """
    And the file "encrypted_message.txt" should contain exactly:
      """
      ESBMY NTMCT BVTNL NJWDN
      """

  Scenario: Decrypting a message file with an alternate deck key and an output file
    Given a file named "alternate_deck.key" with:
      """
      Ah,2h,3h,4h,5h,6h,7h,8h,9h,Th,Jh,Qh,Kh,
      Ac,2c,3c,4c,5c,6c,7c,8c,9c,Tc,Jc,Qc,Kc,ja,
      As,2s,3s,4s,5s,6s,7s,8s,9s,Ts,Js,Qs,Ks,jb,
      Ad,2d,3d,4d,5d,6d,7d,8d,9d,Td,Jd,Qd,Kd,
      """
    And a file named "message_to_decrypt.txt" with:
      """
      ESBMY NTMCT BVTNL NJWDN
      """
    When I run `pontifex decrypt -d alternate_deck.key -o decrypted_message.txt message_to_decrypt.txt`
    Then the output should contain:
      """
      Message decrypted.  You can find the results in the file: decrypted_message.txt
      """
    And the file "decrypted_message.txt" should contain exactly:
      """
      CODEI NRUBY LIVEL ONGER
      """
