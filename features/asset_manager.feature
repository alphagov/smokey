@app-asset-manager @local-network
Feature: Asset Manager
  Scenario: Healthcheck
    Given I am testing "asset-manager" internally
    When I request "/healthcheck/ready"
    Then JSON is returned
    And I should see ""status":"ok""
