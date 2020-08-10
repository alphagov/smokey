@app-finder-frontend
Feature: Finder Frontend
  These are pages that let you search within a set of similar looking documents.

  Background:
    Given I am testing through the full stack
    And I force a varnish cache miss

  @local-network
  Scenario: Healthcheck
    Given I am testing "finder-frontend" internally
    When I request "/healthcheck"
    Then I should get a 200 status code

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
    And I click on the link "Get email alerts"
    Then I should see "Email alert subscription"
    When I click on the button "Create subscription"
    Then I should see "How often do you want to receive emails?"

  Scenario: Email signup from the statistics finder
    When I visit "/search/research-and-statistics"
    And I click on the link "Get email alerts"
    Then I should see "Create subscription"
    And I choose the checkbox "Statistics (published)" and click on "Create subscription"
    Then I should see "How often do you want to receive emails?"

  Scenario: Email signup from a finder (specialist-publisher)
    When I visit "/cma-cases"
    Then I should see "Get email alerts"
    When I click on the link "Get email alerts"
    And I choose the checkbox "Markets" and click on "Create subscription"
    Then I should see "How often do you want to receive emails?"
