@app-link-checker-api @local-network
Feature: Link Checker API
  Scenario: Healthcheck
    Given I am testing "link-checker-api" internally
    When I request "/healthcheck/ready"
    Then JSON is returned
    And I should see ""status":"ok""
