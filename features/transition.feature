Feature: Transition
  Tests for the transition management tools, including the transition app.

  Scenario: Check log in to transition
    When I go to the "transition" landing page
    And I try to login as a user
    And I go to the "transition" landing page
    Then I should see "Sign out"
    And I should see "Organisations"
