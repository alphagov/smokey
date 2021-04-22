@app-maslow @local-network
Feature: Maslow
  Scenario: Healthcheck
    Given I am testing "maslow" internally
    When I request "/healthcheck/ready"
    Then JSON is returned
    And I should see ""status":"ok""
