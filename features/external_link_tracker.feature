Feature: External Link Tracker

Smoke tests

  Scenario: External link tracker is redirecting a link from site search
    Given I am testing through the full stack
    When I try to visit "/g?url=http%3A%2F%2Fwww.cambridge.gov.uk"
    Then I should get a 302 status code
    And I should get a location header of "http://www.cambridge.gov.uk"
    And I should get a cache control header of "no-cache, no-store, must-revalidate"
