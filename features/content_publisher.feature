@app-content-publisher @local-network
Feature: Content Publisher
  Scenario: Healthcheck
    Given I am testing "content-publisher" internally
    When I request "/healthcheck/ready"
    Then JSON is returned
    And I should see ""status":"ok""
