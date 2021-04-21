@app-imminence @local-network
Feature: Imminence
  Scenario: Healthcheck
    Given I am testing "imminence" internally
    When I request "/healthcheck/ready"
    Then JSON is returned
    And I should see ""status":"ok""
