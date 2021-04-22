@app-search-admin @local-network
Feature: Search Admin
  Scenario: Healthcheck
    Given I am testing "search-admin" internally
    When I request "/healthcheck/ready"
    Then JSON is returned
    And I should see ""status":"ok""
