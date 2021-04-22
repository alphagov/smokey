@app-local-links-manager @local-network
Feature: Local Links Manager
  Scenario: Healthcheck
    Given I am testing "local-links-manager" internally
    When I request "/healthcheck/ready"
    Then JSON is returned
    And I should see ""status":"ok""
