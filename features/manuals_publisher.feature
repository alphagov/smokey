@app-manuals-publisher @local-network
Feature: Manuals Publisher
  Scenario: Healthcheck
    Given I am testing "manuals-publisher" internally
    When I request "/healthcheck/ready"
    Then JSON is returned
    And I should see ""status":"ok""
