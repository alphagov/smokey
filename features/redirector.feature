Feature: redirector

Smoke tests

  @high
  Scenario: Redirect from bare domain to www.gov.uk is working
    When I visit "https://gov.uk/" without following redirects
    Then I should get a 301 status code
    And I should get a location of "https://www.gov.uk/"
