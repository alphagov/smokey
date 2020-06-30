Feature: Core GOV.UK behaviour
  Tests for core URL and link behaviour on GOV.UK.

  Scenario: Check paths with a trailing slash are redirected
    When I visit "https://www.gov.uk/browse/benefits/" without following redirects
    Then I should get a 301 status code
    And I should get a "Location" header of "//www.gov.uk/browse/benefits"

  Scenario: Check paths with a trailing full stop are redirected
    When I visit "https://www.gov.uk/browse/benefits." without following redirects
    Then I should get a 301 status code
    And I should get a "Location" header of "//www.gov.uk/browse/benefits"

  Scenario: Check the crown logo links to GOV.UK homepage
    Given I am testing through the full stack
    And I force a varnish cache miss
    When I visit "/"
    Then the logo should link to the homepage

  Scenario: Check entirely upper case slugs redirect to lowercase
    Given I am testing through the full stack
    And I force a varnish cache miss
    When I visit "/GOVERNMENT/ORGANISATIONS" without following redirects
    Then I should get a 301 status code
    And I should be at a location path of "/government/organisations"

  Scenario: Check partially upper case slugs do not redirect
    Given I am testing through the full stack
    And I force a varnish cache miss
    When I visit "/government/organisaTIONS" without following redirects
    Then I should see "Page not found"
