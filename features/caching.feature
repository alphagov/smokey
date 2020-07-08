@aws
Feature: Caching
  Tests that pages are correctly cached

  Background:
    Given I am testing through the full stack

  Scenario: Check council lookup
    When I try to post to "/find-local-council" with "postcode=WC2B+6SE" without following redirects
    Then I should not hit the cache
    Then I should see "camden"

  Scenario: Check licence lookup
    When I try to post to "/busking-licence" with "postcode=E20+2ST" without following redirects
    Then I should not hit the cache
    Then I should see "newham"

  Scenario: Check homepage is served by Varnish
    When I request "/"
    Then I should hit the cache
