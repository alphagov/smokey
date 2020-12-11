@app-collections-publisher @local-network
Feature: Collections Publisher
  Scenario: Healthcheck
    Given I am testing "collections-publisher" internally
    When I request "/healthcheck"
    Then JSON is returned
    And I should see ""status":"ok""
