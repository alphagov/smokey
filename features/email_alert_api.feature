@app-email-alert-api @local-network
Feature: Email Alert API
  Scenario: Healthcheck
    Given I am testing "email-alert-api" internally
    When I request "/healthcheck/ready"
    Then JSON is returned
    And I should see ""status":"ok""
