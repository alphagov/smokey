@app-static @local-network
Feature: Static
  Scenario: Healthcheck
    Given I am testing "static" internally
    When I request "/healthcheck/ready"
    Then JSON is returned
    And I should see ""status":"ok""
