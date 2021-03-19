@app-support @local-network
Feature: support
  Scenario: Healthcheck
    Given I am testing "support" internally
    When I request "/healthcheck"
    Then JSON is returned
    And I should see ""status":"ok""
