@app-account-api @local-network
Feature: Account API
  Scenario: Healthcheck
    Given I am testing "account-api" internally
    When I request "/healthcheck/ready"
    Then JSON is returned
    And I should see ""status":"ok""
