@app-service-manual-publisher @local-network
Feature: Service Manual Publisher
  Scenario: Healthcheck
    Given I am testing "service-manual-publisher" internally
    When I request "/healthcheck/ready"
    Then JSON is returned
    And I should see ""status":"ok""
