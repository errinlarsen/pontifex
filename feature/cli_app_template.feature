Feature: CLI Application Template

  As a programmer writing a CLI application
  I want to utilize a template
  So that I can get started faster

  Scenario: CLI Application Template works out of the box
    When I run `cli_app_template`
    Then the output should contain:
      """
      This has been a test of the cli_app_template
      """
