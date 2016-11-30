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
  Scenario: check that case studies loads
    When I visit "/government/case-studies"
    Then I should see "Case studies: Real-life examples of government activity"
    And I should see an input field to search

  @normal
  Scenario: check policy finder loads
    When I visit "/government/policies"
    Then I should see "Policies"
    And I should see an input field to search

  @normal
  Scenario: check that contacts finder loads
    When I visit "/government/organisations/hm-revenue-customs/contact"
    Then I should see "HM Revenue &amp; Customs Contacts"
    And I should see an input field to search

  @normal
  Scenario: check that statistical data sets loads
    When I visit "/government/statistical-data-sets"
    Then I should see "Statistical data sets"
    And I should see an input field to search
