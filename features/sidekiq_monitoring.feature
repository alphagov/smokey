@app-sidekiq-monitoring @local-network
Feature: Sidekiq Monitoring
  Scenario: Healthcheck
    Given I am testing "sidekiq-monitoring" internally
    When I request "/healthcheck/ready"
    Then JSON is returned
    And I should see ""status":"ok""
