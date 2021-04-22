@app-short-url-manager @local-network
Feature: Short URL manager
  Scenario: Healthcheck
    Given I am testing "short-url-manager" internally
    When I request "/healthcheck/ready"
    Then JSON is returned
    And I should see ""status":"ok""
