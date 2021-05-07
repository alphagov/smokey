@app-signon @replatforming
Feature: Signon
  Tests for signon, the GOV.UK single sign-on service.

  Scenario: Check logging in works
    When I try to login as a user
    Then I should see "Your applications"

  Scenario: Check signon cookies are marked as secure
    When I go to the "signon" landing page
    Then I should receive a "_signonotron2_session" cookie which is "secure"

  @local-network
  Scenario: Healthcheck
    Given I am testing "signon" internally
    When I request "/healthcheck/ready"
    Then JSON is returned
    And I should see ""status":"ok""
