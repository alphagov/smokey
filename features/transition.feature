Feature: Transition
  Tests for the transition management tools, including the transition app.

  Scenario: Check logging in to the transition app works
    When I go to the "transition" landing page
      And I try to login as a user
      And I go to the "transition" landing page
    Then I should see "Sign out"
      And I should see "Organisations"

  Scenario: Check the host list from API to configure CDN works
    When I request "/hosts.json" from the "transition" application
    Then I should get a 200 status code
     And I should see "www.direct.gov.uk"
