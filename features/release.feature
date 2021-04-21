@app-release @local-network
Feature: Release
  Scenario: Healthcheck
    Given I am testing "release" internally
    When I request "/healthcheck/ready"
    Then JSON is returned
    And I should see ""status":"ok""
