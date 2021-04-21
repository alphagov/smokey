@app-content-tagger @local-network
Feature: Content Tagger
  Scenario: Healthcheck
    Given I am testing "content-tagger" internally
    When I request "/healthcheck/ready"
    Then JSON is returned
    And I should see ""status":"ok""
