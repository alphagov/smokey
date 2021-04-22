@app-hmrc-manuals-api @local-network
Feature: HMRC Manuals API
  Scenario: Healthcheck
    Given I am testing "hmrc-manuals-api" internally
    When I request "/healthcheck/ready"
    Then JSON is returned
    And I should see ""status":"ok""
