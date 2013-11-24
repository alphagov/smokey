Feature: Spotlight

  @high
  Scenario: Spotlight application is up and running
    Given I am testing through the full stack
    And I force a varnish cache miss
    When I visit "/performance/deposit-foreign-marriage"
    Then I should get a 200 status code
    And I should see "Deposit foreign marriage or civil partnership certificates"
