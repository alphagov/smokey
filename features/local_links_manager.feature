@app-local-links-manager
Feature: Local Links Manager

  @local_network
  Scenario: Healthcheck
    Given I am testing "local-links-manager" internally
    When I request "/healthcheck"
    Then JSON is returned
    And I should see ""status":"ok""
