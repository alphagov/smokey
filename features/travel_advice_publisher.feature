@app-travel-advice-publisher @local-network
Feature: Travel Advice Publisher
  Scenario: Healthcheck
    Given I am testing "travel-advice-publisher" internally
    When I request "/healthcheck/ready"
    Then JSON is returned
    And I should see ""status":"ok""
