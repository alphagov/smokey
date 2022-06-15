@replatforming
Feature: Caching
  Tests that pages are correctly cached

  Background:
    Given I am testing through the full stack

  # TODO: RENAME to clarify this is testing caching behaviour
  # for POST requests.
  #
  Scenario: Check council lookup
    When I try to post to "/find-local-council" with "postcode=WC2B+6SE" without following redirects
    Then I should not hit the cache
    Then I should see "camden"

  # TODO: REMOVE this test as it does not meet the eligibility
  # criteria in docs/writing-tests.md.
  #
  # - Covers site-wide config: N (already covered)
  # - Targets data transfer: N (already covered)
  # - Second critical check: N (arbitrary page)
  #
  # This page is rendered by Frontend. Data transfer for this
  # app with Licensing is already implicitly covered by
  # "Check licences load".
  #
  # Site-wide config (POST routes are not cached) is already
  # covered by "Check council lookup".
  #
  Scenario: Check licence lookup
    When I try to post to "/busking-licence" with "postcode=E20+2ST" without following redirects
    Then I should not hit the cache
    Then I should see "newham"

  # TODO: RENAME to clarify this is testing caching behaviour
  # behaviour for GET requests.
  #
  Scenario: Check homepage is served by Varnish
    When I request "/"
    Then I should hit the cache
