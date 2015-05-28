Feature: Core GOV.UK behaviour

  @high
  Scenario: Paths with a trailing slash are redirected
    When I visit "https://www.gov.uk/browse/benefits/" without following redirects
    Then I should get a 301 status code
    And I should get a location of "https://www.gov.uk/browse/benefits"
