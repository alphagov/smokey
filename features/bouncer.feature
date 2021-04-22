@app-bouncer @local-network
Feature: Bouncer
  Scenario: Healthcheck
    Given I am testing "bouncer" internally
    When I request "/healthcheck/ready"
    Then JSON is returned
    And I should see ""status":"ok""
