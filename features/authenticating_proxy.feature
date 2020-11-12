@app-authenticating-proxy
Feature: Authenticating Proxy

  @local-network
  Scenario: Healthcheck
    Given I am testing "collections" internally
    When I request "/healthcheck"
    Then I should get a 200 status code
