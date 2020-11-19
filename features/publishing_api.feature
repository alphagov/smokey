@app-publishing-api @local-network
Feature: Publishing API
  Scenario: Healthcheck
    Given I am testing "publishing-api" internally
    When I request "/healthcheck"
    Then JSON is returned
    And I should see ""status":"ok""
