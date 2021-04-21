@app-service-manual-frontend @local-network
Feature: Service Manual Frontend
  Scenario: Healthcheck
    Given I am testing "service-manual-frontend" internally
    When I request "/healthcheck/ready"
    Then JSON is returned
    And I should see ""status":"ok""
