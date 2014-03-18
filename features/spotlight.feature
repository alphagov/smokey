@notproduction
Feature: Spotlight

  @high
  Scenario: Performance Platform homepage is available
    Given I am testing through the full stack
    And I force a varnish cache miss
    When I visit "/performance"
    Then I should get a 200 status code
    And I should see "Our performance"

  @high
  Scenario: Spotlight application is up and running
    Given I am testing through the full stack
    And I force a varnish cache miss
    When I visit "/performance/carers-allowance"
    Then I should get a 200 status code
    And I should see "Carer's Allowance"
