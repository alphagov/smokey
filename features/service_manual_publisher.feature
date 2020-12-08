@app-service-manual-publisher
Feature: Service Manual Publisher

  @local-network
  Scenario: Healthcheck
    Given I am testing "service-manual-publisher" internally
    When I request "/healthcheck"
    Then I should get a 200 status code
