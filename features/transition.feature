Feature: Transition
  Tests for the transition management tools, including the transition app.

  Scenario: Check logging in to the transition app works
    When I go to the "transition" landing page
      And I try to login as a user
      And I go to the "transition" landing page
    Then I should see "Sign out"
      And I should see "Organisations"

  # TODO: REMOVE this test as it does not meet the eligibility
  # criteria in docs/writing-tests.md.
  #
  # - Covers site-wide config: N (not applicable)
  # - Targets data transfer: N (no other apps involved)
  # - Second critical check: N (not a critical feature)
  #
  # This functionality is only used during deploys of Bouncer.
  # Tested in Transition through a combination of unit, controller
  # and feature tests.
  #
  Scenario: Check the host list from API to configure CDN works
    When I request "/hosts.json" from the "transition" application
    Then I should get a 200 status code
     And I should see "www.direct.gov.uk"
