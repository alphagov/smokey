@app-finder-frontend @replatforming
Feature: Finder Frontend
  These are pages that let you search within a set of similar looking documents.

  Background:
    Given I am testing through the full stack
    And I consent to cookies
    And I force a varnish cache miss

  # TODO: RENAME to clarify this is testing data transfer with
  # Content Store (as the prime example for this app).
  #
  Scenario: Check people page loads correctly
    When I visit "/government/people"
    Then I should see "All ministers and senior officials on GOV.UK"
    And I should see an input field to search

  # TODO: REMOVE this test as it does not meet the eligibility
  # criteria in docs/writing-tests.md.
  #
  # - Covers site-wide config: N (not applicable)
  # - Targets data transfer: N (already covered)
  # - Second critical check: N (arbitrary page)
  #
  # Data transfer with Content Store is already covered by
  # "Check people page loads correctly".
  #
  Scenario: Check world organisations loads correctly
    When I visit "/world/organisations"
    Then I should see "Worldwide organisations"
    And I should see an input field to search

  # TODO: REMOVE this test as it does not meet the eligibility
  # criteria in docs/writing-tests.md.
  #
  # - Covers site-wide config: N (not applicable)
  # - Targets data transfer: N (already covered)
  # - Second critical check: N (arbitrary page)
  #
  # Data transfer with Content Store is already covered by
  # "Check people page loads correctly".
  #
  Scenario: Check groups loads correctly
    When I visit "/government/groups"
    Then I should see "Groups"
    And I should see an input field to search

  # TODO: REMOVE this test as it does not meet the eligibility
  # criteria in docs/writing-tests.md.
  #
  # - Covers site-wide config: N (not applicable)
  # - Targets data transfer: N (already covered)
  # - Second critical check: N (arbitrary page)
  #
  # Data transfer with Content Store is already covered by
  # "Check people page loads correctly".
  #
  Scenario: Check case studies loads correctly
    When I visit "/government/case-studies"
    Then I should see "Case studies: Real-life examples of government activity"
    And I should see an input field to search

  # TODO: REMOVE this test as it does not meet the eligibility
  # criteria in docs/writing-tests.md.
  #
  # - Covers site-wide config: N (not applicable)
  # - Targets data transfer: N (already covered)
  # - Second critical check: N (arbitrary page)
  #
  # Data transfer with Content Store is already covered by
  # "Check people page loads correctly".
  #
  Scenario: Check contacts finder loads correctly
    When I visit "/government/organisations/hm-revenue-customs/contact"
    Then I should see "Contact HM Revenue &amp; Customs"
    And I should see an input field to search

  # TODO: REMOVE this test as it does not meet the eligibility
  # criteria in docs/writing-tests.md.
  #
  # - Covers site-wide config: N (not applicable)
  # - Targets data transfer: N (already covered)
  # - Second critical check: N (arbitrary page)
  #
  # Data transfer with Content Store is already covered by
  # "Check people page loads correctly".
  #
  Scenario: Check statistical data sets loads correctly
    When I visit "/government/statistical-data-sets"
    Then I should see "Statistical data sets"
    And I should see an input field to search

  # TODO: REMOVE this test as it does not meet the eligibility
  # criteria in docs/writing-tests.md.
  #
  # - Covers site-wide config: N (not applicable)
  # - Targets data transfer: N (already covered)
  # - Second critical check: N (not a critical feature)
  #
  # Data transfer with Search API is already covered by
  # "Check search results and analytics".
  #
  # This test is also checking that (filter) facet options are
  # shown from the content item. Data transfer from Content Store
  # is already covered by "Check search results and analytics".
  # The functionality is also tested in app [^1].
  #
  # [^1]: https://github.com/alphagov/finder-frontend/blob/d70a01903e2813719e7d5adbf79fbcb1d49335fb/features/finders.feature#L18-L19
  #
  Scenario: Check specialist documents are searchable
    When I visit "/cma-cases?keywords=merger"
    Then I should see filtered documents
    And I should see an open facet titled "Case type" with non-blank values

  # TODO: EXPORT this test as it does not meet the elgibility
  # criteria in docs/writing-tests.md.
  #
  # - Covers site-wide config: N (not applicable)
  # - Targets data transfer: N (already covered)
  # - Second critical check: N (not tested in app)
  #
  # Data transfer with Content Store is already covered by
  # "Check the "Contact GOV.UK" page loads correctly".
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

  # TODO: REMOVE this test as it does not meet the elgibility
  # criteria in docs/writing-tests.md.
  #
  # - Covers site-wide config: N (not applicable)
  # - Targets data transfer: N (already covered)
  # - Second critical check: N (arbitrary page)
  #
  # Data transfer with Content Store and Email Alert API is
  # already covered by "Email signup from the statistics finder".
  #
  # Also tested in app [^1].
  #
  # [^1]: https://github.com/alphagov/finder-frontend/blob/d70a01903e2813719e7d5adbf79fbcb1d49335fb/features/finders.feature#L229
  #
  Scenario: Email signup from the news and communications finder
    When I visit "/search/news-and-communications"
    And I click on the link "Get emails"
    And I click on the button "Continue"
    Then I should see "How often do you want to get emails?"

  # TODO: RENAME to clarify this is testing data transfer with
  # Email Alert API (as the prime example for the app).
  #
  # Note: this scenario covers additional selection functionality
  # compared to others, hence making it the prime example.
  #
  Scenario: Email signup from the statistics finder
    When I visit "/search/research-and-statistics"
    And I click on the link "Get emails"
    And I choose the checkbox "Statistics (published)" and click on "Continue"
    Then I should see "How often do you want to get emails?"

  # TODO: REMOVE this test as it does not meet the elgibility
  # criteria in docs/writing-tests.md.
  #
  # - Covers site-wide config: N (not applicable)
  # - Targets data transfer: N (already covered)
  # - Second critical check: N (arbitrary page)
  #
  # Data transfer with Content Store and Email Alert API is
  # already covered by "Email signup from the statistics finder".
  #
  # Also tested in app [^1][^2].
  #
  # [^1]: https://github.com/alphagov/finder-frontend/blob/d70a01903e2813719e7d5adbf79fbcb1d49335fb/features/finders.feature#L181
  # [^2]: https://github.com/alphagov/finder-frontend/blob/d70a01903e2813719e7d5adbf79fbcb1d49335fb/features/step_definitions/filtering_steps.rb#L511
  #
  Scenario: Email signup from a finder (specialist-publisher)
    When I visit "/cma-cases"
    When I click on the link "Get emails"
    And I choose the checkbox "Markets" and click on "Continue"
    Then I should see "How often do you want to get emails?"

  # TODO: RENAME to clarify this is testing data transfer
  # with Search API (as the prime example for this app).
  #
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

  # TODO: REMOVE this test as it does not meet the elgibility
  # criteria in docs/writing-tests.md.
  #
  # - Covers site-wide config: N (not applicable)
  # - Targets data transfer: N (already covered)
  # - Second critical check: N (disabled)
  #
  # Data transfer with Content Store and Search API is already
  # covered by "Check search results and analytics".
  #
  # This feature has been disabled for a long time [^1]. Also
  # tested in app [^2].
  #
  # [^1]: https://github.com/alphagov/smokey/commit/418017e3af2eb9ee048e05034344f5806d27513b
  # [^2]: https://github.com/alphagov/finder-frontend/blob/58af994675ef7f4e375b0ceac5f8b14ccf65bf44/features/finders.feature#L207
  #
  @pending
  Scenario: Check organisation filtering
    When I search for "policy"
    Then I should see organisations in the organisation filter

  # TODO: EXPORT this test as it does not meet the elgibility
  # criteria in docs/writing-tests.md.
  #
  # - Covers site-wide config: N (not applicable)
  # - Targets data transfer: N (already covered)
  # - Second critical check: N (not tested in app)
  #
  # Data transfer with Content Store is already covered by
  # "Check the "Contact GOV.UK" page loads correctly".
  #
  # Should be tested in Finder Frontend [^1].
  #
  # [^1]: https://github.com/alphagov/finder-frontend/pull/480/files#diff-784cf53d64014a1a65ca518c1891efbc3fe9b4fb02d0e0e2dfed07acb9c5b0d1R3  #
  #
  Scenario: Check malicious code does not execute
    When I search for "<script>alert(document.cookie)</script>"
    Then I see the code returned in the page
