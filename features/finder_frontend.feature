Feature: Finder Frontend
  These are pages that let you search within a set of similar looking documents.

  Background:
    Given I am testing through the full stack
    And I force a varnish cache miss

  @normal
  Scenario: check people page loads
    When I visit "/government/people"
    Then I should see "All ministers and senior officials on GOV.UK"
    And I should see an input field to search

  @normal
  Scenario: check policy page loads
    When I visit "/government/policies"
    Then I should see "Policies"
    And I should see an input field to search
    And I should see an open facet titled "Organisation" with non-blank values

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
  Scenario: check that contacts finder loads
    When I visit "/government/organisations/hm-revenue-customs/contact"
    Then I should see "Contact HM Revenue &amp; Customs"
    And I should see an input field to search

  @normal
  Scenario: check that statistical data sets loads
    When I visit "/government/statistical-data-sets"
    Then I should see "Statistical data sets"
    And I should see an input field to search

  @normal
  Scenario: check that specialist documents are searchable
    When I visit "/cma-cases?keywords=merger"
    Then I should see filtered documents

  @normal
  Scenario: check that advanced search returns results
    When I visit "/search/advanced?topic=/education&group=news_and_communications"
    Then I should see filtered documents

  @high
  Scenario: check malicious code does not execute
    When I visit "/government/organisations/hm-revenue-customs/contact?keywords=<script>alert(document.cookie);</script>"
    Then I should see "&lt;script&gt;alert(document.cookie)"
