@app-sidekiq-monitoring

Feature: Sidekiq Monitoring

  @local-network
  Scenario: Healthcheck
    Given I am testing "sidekiq-monitoring" internally
    When I request "/healthcheck"
    Then JSON is returned
    And I should see ""status":"ok""
