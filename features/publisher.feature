@app-publisher
Feature: (Mainstream) Publisher

  @local-network
  Scenario: Healthcheck
    Given I am testing "publisher" internally
    When I request "/healthcheck/ready"
    Then JSON is returned
    And I should see ""status":"ok""
