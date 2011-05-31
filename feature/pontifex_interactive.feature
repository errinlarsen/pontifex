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
      GLNCQ MJAFF FVOMB JIYCB
      """

  Scenario: Decrypting a message with Pontifex interactively
    When I run `pontifex decrypt` interactively
    And I type "GLNCQ MJAFF FVOMB JIYCB"
    And I type "Done"
    Then the output should contain:
      """
      CODEI NRUBY LIVEL ONGER
      """
