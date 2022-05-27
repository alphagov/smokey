@replatforming @app-whitehall
Feature: Whitehall
  Tests for the whitehall application that powers some pages under
  www.gov.uk/government and www.gov.uk/world.

  Background:
    Given I am testing through the full stack
    And I force a varnish cache miss

  # TODO: REMOVE this test as it does not meet the eligibility
  # criteria in docs/writing-tests.md.
  #
  # - Covers site-wide config: N (not applicable)
  # - Targets data transfer: N (already covered)
  # - Second critical check: N (no content tested)
  #
  # This page is actually rendered by Frontend. Data transfer for
  # this app with Content Store is implicitly covered by
  # "Check homepage content type and charset".
  #
  # The step for this scenario only checks a CSS element exists.
  # CSS classes are not a feature of GOV.UK.
  #
  Scenario: Check the government publishing section on GOV.UK homepage
    Then I should see the Government activity section on the homepage

  # TODO: REMOVE this test as it does not meet the eligibility
  # criteria in docs/writing-tests.md.
  #
  # - Covers site-wide config: N (not applicable)
  # - Targets data transfer: N (already covered)
  # - Second critical check: N (no content tested)
  #
  # These pages are actually rendered by Finder Frontend. Data
  # transfer for this app with Search API is already covered by
  # "Check search results and analytics". Also tested in app [^1].
  #
  # [^1]: https://github.com/alphagov/finder-frontend/blob/d70a01903e2813719e7d5adbf79fbcb1d49335fb/spec/controllers/finders_controller_spec.rb#L73
  #
  Scenario: Check feeds are available for documents
    Then I should be able to visit:
      | Path                           |
      | /government/announcements.atom |
      | /government/statistics.atom  |

  # TODO: REMOVE the following examples (rendered by other apps).
  #
  # 1. /government/how-government-works (Government Frontend)
  # 2. /government/people/eric-pickles (Collections)
  #
  # At best this scenario implicitly checks for data transfer
  # with Content Store and is covered to the same extent for both
  # apps e.g. "Ensure static content is rendered".
  #
  # TODO: REMOVE the following example.
  #
  # 3. /world
  #
  # This example does not meet the eligibility criteria in
  # docs/writing-tests.md.
  #
  # - Covers site-wide config: N (not applicable)
  # - Targets data transfer: N (no other apps involved)
  # - Second critical check: N (no content tested)
  #
  # /world is not present in Content Store.
  #
  # TODO: RENAME to clarify this is testing data transfer with
  # Content Store (as the prime example for this app).
  #
  # This test is poor quality as content is not explicitly tested,
  # but there are no better tests to choose from.
  #
  Scenario Outline: Check whitehall pages load
    When I request "<Path>"
    Then I should get a 200 status code

    Examples:
      | Path                             |
      | /government/how-government-works |
      | /government/ministers            |
      | /government/people/eric-pickles  |
      | /world                           |

  Scenario: Check whitehall assets are redirected to and served from the asset host
    When I request an attachment
    Then I should be redirected to the asset host
    And the attachment should be served successfully
