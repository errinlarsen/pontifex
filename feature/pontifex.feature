Feature: Pontifex (Solitaire) cipher

  As a programmer writing a CLI application
  I want to utilize a template
  So that I can get started faster

  Scenario: CLI Application Template works out of the box
    When I run `pontifex`
    Then the exit status should be 0
