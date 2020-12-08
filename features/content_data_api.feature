@app-content-data-api @local-network
Feature: Content Data API
  Scenario: Healthcheck
    Given I am testing "content-data-api" internally
    When I request "/healthcheck"
    Then JSON is returned
    And I should see ""status":"ok""
