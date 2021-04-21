@app-content-store @local-network
Feature: Content Store
  Scenario: Healthcheck
    Given I am testing "content-store" internally
    When I request "/healthcheck/ready"
    Then JSON is returned
    And I should see ""status":"ok""
