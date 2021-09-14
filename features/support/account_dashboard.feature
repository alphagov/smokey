@app-account-dashboard
Feature: Account dashboard
  Scenario: Check that the sign out links are available in the Accounts dashboard
    Given I am testing through the full stack
    And I force a varnish cache miss
    When I visit "/account/home"
    Then I should see "Sign in to your GOV.UK account"
    When I sign in to my GOV.UK account
    Then I should see "Sign out"
