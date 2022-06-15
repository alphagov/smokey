@replatforming
Feature: Caching
  Tests that pages are correctly cached

  Scenario: Check caching behaviour for POST requests
    When I try to post to "/find-local-council" with "postcode=WC2B+6SE" without following redirects
    Then I should not hit the cache
    Then I should see "camden"

  Scenario: Check caching behaviour for GET requests
    When I request "/"
    Then I should hit the cache
