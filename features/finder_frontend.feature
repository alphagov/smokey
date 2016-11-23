Feature: Finder Frontend
  This are pages that have been migrated to a finder instead of index pages.

  Background:
    Given I am testing through the full stack
    And I force a varnish cache miss

  @normal
  Scenario: check people page loads
    When I visit "/government/people"
    Then I should see "All ministers and senior officials on GOV.UK"
    And I should see an input field to search

  @normal
  Scenario: check world organisations loads
    When I visit "/government/world/organisations"
    Then I should see "Worldwide organisations"
    And I should see an input field to search

  @normal
  Scenario: check world organisations loads
    When I visit "/government/groups"
    Then I should see "Groups"
    And I should see an input field to search

  @normal
  Scenario: check world organisations loads
    When I visit "/government/statistical-data-sets"
    Then I should see "Groups"
    And I should see an input field to search
