Feature: Core GOV.UK behaviour

  @high
  Scenario: Paths with a trailing slash are redirected
    When I visit "https://www.gov.uk/browse/benefits/" without following redirects
    Then I should get a 301 status code
    And I should get a location of "/browse/benefits"

  @normal
  Scenario: Crown logo links to GOV.UK homepage
    Given I am testing through the full stack
    And I force a varnish cache miss
    When I visit "/"
    Then the logo should link to the homepage

  @normal
  Scenario: entirely upper case slugs redirect to lowercase
    Given I visit "/GOVERNMENT/PUBLICATIONS" without following redirects
    Then I should get a 301 status code
    And I should get a location of "/government/publications"

  @normal
  Scenario: partially upper case slugs do not redirect
    When I try to visit "/government/publicatIONS"
    Then I should get a 404 status code


