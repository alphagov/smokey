@aws @app-finder-frontend
Feature: Finder Frontend
  These are pages that let you search within a set of similar looking documents.

  Background:
    Given I am testing through the full stack
    And I consent to cookies
    And I force a varnish cache miss

  Scenario: Check people page loads correctly
    When I visit "/government/people"
    Then I should see "All ministers and senior officials on GOV.UK"
    And I should see an input field to search

  Scenario: Check world organisations loads correctly
    When I visit "/world/organisations"
    Then I should see "Worldwide organisations"
    And I should see an input field to search

  Scenario: Check groups loads correctly
    When I visit "/government/groups"
    Then I should see "Groups"
    And I should see an input field to search

  Scenario: Check case studies loads correctly
    When I visit "/government/case-studies"
    Then I should see "Case studies: Real-life examples of government activity"
    And I should see an input field to search

  Scenario: Check contacts finder loads correctly
    When I visit "/government/organisations/hm-revenue-customs/contact"
    Then I should see "Contact HM Revenue &amp; Customs"
    And I should see an input field to search

  Scenario: Check statistical data sets loads correctly
    When I visit "/government/statistical-data-sets"
    Then I should see "Statistical data sets"
    And I should see an input field to search

  Scenario: Check specialist documents are searchable
    When I visit "/cma-cases?keywords=merger"
    Then I should see filtered documents
    And I should see an open facet titled "Case type" with non-blank values

  Scenario Outline: Check malicious code does not execute
    When I visit the "<finder>" finder with keywords <keyword>
    Then There should be no alert
    When I visit the "<finder>" finder without keywords
    And I fill in the keyword field with <keyword>
    Then There should be no alert
    And I should see the string <keyword>

  Examples:
    | keyword                     | finder                  |
    | <script>alert(123)</script> | news-and-communications |
    | <script>alert(123)</script> | all                     |

  Scenario: Email signup from the news and communications finder
    When I visit "/search/news-and-communications"
    And I click on the link "Get emails"
    And I click on the button "Continue"
    Then I should see "How often do you want to get emails?"

  Scenario: Email signup from the statistics finder
    When I visit "/search/research-and-statistics"
    And I click on the link "Get emails"
    And I choose the checkbox "Statistics (published)" and click on "Continue"
    Then I should see "How often do you want to get emails?"

  Scenario: Email signup from a finder (specialist-publisher)
    When I visit "/cma-cases"
    When I click on the link "Get emails"
    And I choose the checkbox "Markets" and click on "Continue"
    Then I should see "How often do you want to get emails?"

  Scenario Outline: Check search results and analytics
    When I search for "<keywords>"
    Then I should see some search results
    And the search results should be unique
    Then search analytics for "<keywords>" are reported
    When I go to the next page
    Then the "contentsClicked" event is reported
    When I click result 1
    Then the "navFinderLinkClicked" event for result Search.1 is reported
    Then the "UX" event for result click is reported

    Examples:
    | keywords         |
    | tax              |
    | passport         |
    | universal credit |

  @pending
  Scenario: Check organisation filtering
    When I search for "policy"
    Then I should see organisations in the organisation filter

  Scenario: Check malicious code does not execute
    When I search for "<script>alert(document.cookie)</script>"
    Then I see the code returned in the page
