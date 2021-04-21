@app-support-api @local-network
Feature: Support API
  Scenario: Healthcheck
    Given I am testing "support-api" internally
    When I request "/healthcheck/ready"
    Then JSON is returned
    And I should see ""status":"ok""
