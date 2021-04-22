@app-contacts-admin @local-network
Feature: Contacts Admin
  Scenario: Healthcheck
    Given I am testing "contacts-admin" internally
    When I request "/healthcheck/ready"
    Then JSON is returned
    And I should see ""status":"ok""
