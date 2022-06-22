@app-finder-frontend @replatforming
Feature: Finder Frontend
  Background:
    Given I consent to cookies

  Scenario: Check the frontend can talk to Content Store
    When I visit "/government/people"
    Then I should see "All ministers and senior officials on GOV.UK"
    And I should see an input field to search

  # TODO: EXPORT this test as it does not meet the elgibility
  # criteria in docs/writing-tests.md.
  #
  # - Covers site-wide config: N (not applicable)
  # - Targets data transfer: N (already covered)
  # - Second critical check: N (not tested in app)
  #
  # Data transfer with Content Store is already covered by
  # "Check the frontend can talk to Content Store".
  #
  # Was and should be tested in Finder Frontend [^1].
  #
  # [^1]: https://github.com/alphagov/finder-frontend/pull/1054/files#diff-0822261922afb44074aad6403cc2a1d762f897995e9aa1c6a93ece100515117aL23
  #
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

  Scenario: Check the frontend can talk to Email Alert API
    When I visit "/search/research-and-statistics"
    And I click on the link "Get emails"
    And I choose the checkbox "Statistics (published)" and click on "Continue"
    Then I should see "How often do you want to get emails?"

  Scenario Outline: Check the frontend can talk to Search API
    When I search for "<keywords>"
    Then I should see some search results
    And the search results should be unique
    And search analytics for "<keywords>" are reported
    When I go to the next page
    Then the "contentsClicked" event is reported
    When I click result 1
    Then the "navFinderLinkClicked" event for result Search.1 is reported
    And the "UX" event for result click is reported

    Examples:
    | keywords         |
    | tax              |
    | passport         |
    | universal credit |

  # TODO: EXPORT this test as it does not meet the elgibility
  # criteria in docs/writing-tests.md.
  #
  # - Covers site-wide config: N (not applicable)
  # - Targets data transfer: N (already covered)
  # - Second critical check: N (not tested in app)
  #
  # Data transfer with Content Store is already covered by
  # "Check the frontend can talk to Content Store".
  #
  # Should be tested in Finder Frontend [^1].
  #
  # [^1]: https://github.com/alphagov/finder-frontend/pull/480/files#diff-784cf53d64014a1a65ca518c1891efbc3fe9b4fb02d0e0e2dfed07acb9c5b0d1R3  #
  #
  Scenario: Check malicious code does not execute
    When I search for "<script>alert(document.cookie)</script>"
    Then I see the code returned in the page

  # TODO: EXPORT this test as it does not meet the eligibility
  # criteria in docs/writing-tests.md.
  #
  # - Covers site-wide config: N (not applicable)
  # - Targets data transfer: N (not applicable)
  # - Second critical check: N (not tested in app)
  #
  # Should be tested in Finder Frontend, if at all, when the app
  # takes over from Static and renders its own layout [^1].
  #
  # [^1]: https://github.com/alphagov/smokey/pull/976#discussion_r903528402
  #
  Scenario: Check the feedback component loads
    When I visit "/search/news-and-communications"
    And I confirm it is rendered by "finder-frontend"
    And I can operate the feedback component
