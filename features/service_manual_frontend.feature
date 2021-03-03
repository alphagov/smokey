@app-service-manual-frontend
Feature: Service Manual Frontend

  @local-network
  Scenario: Healthcheck
    Given I am testing "service-manual-frontend" internally
    When I request "/healthcheck"
    Then I should get a 200 status code
