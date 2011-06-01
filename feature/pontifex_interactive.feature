Feature: Pontifex (Solitaire) cipher

  As a spy sending a secret message
  I want to utilize a cipher
  So that I can encrypt my message

  Scenario: Encrypting a message with Pontifex interactively
    When I run `pontifex encrypt` interactively
    And I type "Code in Ruby, live longer!"
    And I type "Done"
    Then the output should contain:
      """
      Enter the message to encrypt.
      enter 'Done' on a line by itself when you are done
      """      
    And the output should contain:
      """
      GLNCQ MJAFF FVOMB JIYCB
      """

  Scenario: Decrypting a message with Pontifex interactively
    When I run `pontifex decrypt` interactively
    And I type "GLNCQ MJAFF FVOMB JIYCB"
    And I type "Done"
    Then the output should contain:
      """
      Enter the message to encrypt.
      enter 'Done' on a line by itself when you are done
      """      
    And the output should contain:
      """
      CODEI NRUBY LIVEL ONGER
      """

  Scenario: Encrypting a multi-line message, with more than 25 valid characters, interactively
    When I run `pontifex encrypt` interactively
    And I type "abcdefghijklmnopqrstuvwxyz"
    And I type "abcdefghijklmnopqrstuvwxyz"
    And I type "Done"
    Then the output should contain:
      """
      EYMBM EYNMQ EYFVE KLJQD UUTWG
      CPXUP AXBNV IRGUS GIRPI NBDBM
      GAYAC
      """

  Scenario: Decrypting a multi-line message, with more than 25 valid characters, interactively
    When I run `pontifex decrypt` interactively
    And I type "EYMBM EYNMQ EYFVE KLJQD UUTWG"
    And I type "CPXUP AXBNV IRGUS GIRPI NBDBM"
    And I type "GAYAC"
    And I type "Done"
    Then the output should contain:
      """
      ABCDE FGHIJ KLMNO PQRST UVWXY
      ZABCD EFGHI JKLMN OPQRS TUVWX
      YZXXX
      
      """

  Scenario: Encrypting a multi-line message with an alternate key interactively
    Given a file named "alternate_deck.key" with:
      """
      Ad,2d,3d,4d,5d,6d,7d,8d,9d,Td,Jd,Qd,Kd,
      Ac,2c,3c,4c,5c,6c,7c,8c,9c,Tc,Jc,Qc,Kc,ja,
      Ah,2h,3h,4h,5h,6h,7h,8h,9h,Th,Jh,Qh,Kh,jb,
      As,2s,3s,4s,5s,6s,7s,8s,9s,Ts,Js,Qs,Ks
      """
    When I run `pontifex encrypt -d alternate_deck.key` interactively
    And I type "abcdefghijklmnopqrstuvwxyz"
    And I type "abcdefghijklmnopqrstuvwxyz"
    And I type "Done"
    Then the output should contain:
      """
      CPMJC AEFIK OOXGI VHYTU GYZYA
      VRMKB EFOXV ECFPY KEOBY SXIZE
      WPDFJ

      """

  Scenario: Decrypting a multi-line message with an alternate key interactively
    Given a file named "alternate_deck.key" with:
      """
      Ad,2d,3d,4d,5d,6d,7d,8d,9d,Td,Jd,Qd,Kd,
      Ac,2c,3c,4c,5c,6c,7c,8c,9c,Tc,Jc,Qc,Kc,ja,
      Ah,2h,3h,4h,5h,6h,7h,8h,9h,Th,Jh,Qh,Kh,jb,
      As,2s,3s,4s,5s,6s,7s,8s,9s,Ts,Js,Qs,Ks
      """
    When I run `pontifex decrypt -d alternate_deck.key` interactively
    And I type "CPMJC AEFIK OOXGI VHYTU GYZYA"
    And I type "VRMKB EFOXV ECFPY KEOBY SXIZE"
    And I type "WPDFJ"
    And I type "Done"
    Then the output should contain:
      """
      ABCDE FGHIJ KLMNO PQRST UVWXY
      ZABCD EFGHI JKLMN OPQRS TUVWX
      YZXXX

      """
