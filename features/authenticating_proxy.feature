@app-authenticating-proxy
Feature: Authenticating Proxy

  @local-network
  Scenario: Healthcheck
    Given I am testing "collections" internally
    When I request "/healthcheck/ready"
    Then JSON is returned
    And I should see ""status":"ok""
