Feature: Redirect of gov.uk to www.gov.uk

Smoke tests

  @high
  Scenario: Redirect from bare domain to www.gov.uk is working
    When I visit "https://gov.uk/" without following redirects
    Then I should get a 301 status code
    And I should get a location of "https://www.gov.uk/"

  @normal
  Scenario: Redirect from service domain to GOV.UK with HSTS
    When I visit "https://service.gov.uk/" without following redirects
    Then I should get a 302 status code
    And I should get a location of "https://www.gov.uk"
    And I should get a "Strict-Transport-Security" header of "max-age=63072000; includeSubDomains; preload"
