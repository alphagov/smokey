@app-email-alert-frontend @local-network
Feature: Email Alert Frontend
  Scenario: Healthcheck
    Given I am testing "email-alert-frontend" internally
    When I request "/healthcheck/ready"
    Then JSON is returned
    And I should see ""status":"ok""
