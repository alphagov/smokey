Feature: Sign-on-o-tron
  @high
  Scenario: Can log in
    Given the "signon" application has booted
    When I try to login as a user
    Then I should see "Welcome to GOV.UK"

