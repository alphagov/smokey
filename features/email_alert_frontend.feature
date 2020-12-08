@app-email-alert-frontend
Feature: Email Alert Frontend

  @local-network
  Scenario: Healthcheck
    Given I am testing "email-alert-frontend" internally
    When I request "/healthcheck"
    Then JSON is returned
    And I should see ""status":"ok""
