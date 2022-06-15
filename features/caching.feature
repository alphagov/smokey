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

  # TODO: RENAME to clarify this is testing caching behaviour
  # behaviour for GET requests.
  #
  Scenario: Check homepage is served by Varnish
    When I request "/"
    Then I should hit the cache
