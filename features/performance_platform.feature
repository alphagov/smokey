Feature: Performance Platform

  Background:
    Given I am testing through the full stack

  @high @notintegration @notstaging
  Scenario: Check the Performance Platform homepage loads
    When I visit "/performance"
    Then I should see "Performance"
    And I should see "Find performance data of government services"

  @normal @notintegration @notstaging
  Scenario: Check a Performance Platform dashboard loads
    When I visit "/performance/register-to-vote"
    Then I should see "Voter registration"
