@app-specialist-publisher @local-network
Feature: Specialist Publisher
  Scenario: Healthcheck
    Given I am testing "specialist-publisher" internally
    When I request "/healthcheck/ready"
    Then JSON is returned
    And I should see ""status":"ok""
