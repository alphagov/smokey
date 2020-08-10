@app-travel-advice-publisher @local-network
Feature: Travel Advice Publisher
  Scenario: Healthcheck
    Given I am testing "travel-advice-publisher" internally
    When I request "/healthcheck"
    Then I should get a 200 status code
