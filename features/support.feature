@app-support @local-network
Feature: Support
  Scenario: Healthcheck
    Given I am testing "support" internally
    When I request "/healthcheck/ready"
    Then JSON is returned
    And I should see ""status":"ok""
