@aws
Feature: Search
  Tests for the GOV.UK search engine.

  Background:
    Given I am testing through the full stack
    And I consent to cookies
    And I force a varnish cache miss for search

  @app-finder-frontend
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

  @pending @app-finder-frontend
  Scenario: Check organisation filtering
    When I search for "policy"
    Then I should see organisations in the organisation filter

  @app-finder-frontend
  Scenario: Check malicious code does not execute
    When I search for "<script>alert(document.cookie)</script>"
    Then I see the code returned in the page
