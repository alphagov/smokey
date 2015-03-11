Feature: Performance Platform

  @high
  Scenario: Performance Platform homepage is available
    Given I am testing through the full stack
    And I force a varnish cache miss
    And I am benchmarking
    When I visit "/performance"
    Then I should get a 200 status code
    And I should see "Performance"

  @high
  Scenario: Performance Platform dashboards are available
    Given I am testing through the full stack
    And I force a varnish cache miss
    And I am benchmarking
    When I visit "/performance/carers-allowance"
    Then I should get a 200 status code
    And I should see "Carer's Allowance"
