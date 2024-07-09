@app-finder-frontend
Feature: Finder Frontend
  @worksonmirror
  Scenario: Check the frontend can talk to Content Store
    When I visit "/government/people"
    Then I should see "All ministers and senior officials on GOV.UK"
    And I should see an input field to search

  @app-email-alert-frontend
  Scenario: Check the frontend can talk to Email Alert API
    When I visit "/search/research-and-statistics"
    And I click on the link "Get emails"
    And I choose the checkbox "Statistics (published)" and click on "Continue"
    Then I should see "How often do you want to get emails?"

  @notcloudfront
  Scenario Outline: Check the frontend can talk to Search API
    Given I consent to cookies
    When I search for "<keywords>"
    Then I should see some search results

    Examples:
    | keywords         |
    | tax              |
    | passport         |
    | universal credit |
