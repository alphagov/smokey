Feature: Contracts Finder

  Scenario: is available
    When I try to visit the contracts finder home page
    Then I should be on the contracts finder home page

  Scenario: Quickly loading the contracts finder home page
    Given I am benchmarking
    When I try to visit the contracts finder home page
    Then the elapsed time should be less than 3 seconds

