@app-bouncer
Feature: Bouncer

  @local-network @aws
  Scenario: Healthcheck
    Given I am testing "bouncer" internally
    When I request "/healthcheck"
    Then JSON is returned
    And I should see ""status":"ok""
