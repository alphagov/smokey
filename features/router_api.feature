@app-router-api @local-network
Feature: Router API
  Scenario: Healthcheck
    Given I am testing "router-api" internally
    When I request "/healthcheck/ready"
    Then JSON is returned
    And I should see ""status":"ok""
