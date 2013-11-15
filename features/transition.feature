Feature: Transition management tools

  @high
  Scenario: Can log in to transition app
    Given the "signon" application has booted
      And the "transition" application has booted
    When I go to the "transition" landing page
      And I try to login as a user
      And I go to the "transition" landing page
    Then I should see "Sign out"
      And I should see "Organisations"
