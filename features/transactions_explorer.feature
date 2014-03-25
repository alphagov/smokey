Feature: Transactions Explorer

  Scenario: Transactions Explorer main page is available
    Given I am testing through the full stack
    And I force a varnish cache miss
    When I visit "/performance/transactions-explorer/all-services/by-transactions-per-year/descending"
    Then I should get a 200 status code
    And I should see "Transactions Explorer"
