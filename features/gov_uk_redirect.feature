Feature: Redirect of gov.uk to www.gov.uk
  Scenario: Check redirect from bare domain to www.gov.uk is working for HTTP
    When I visit "http://gov.uk/" without following redirects
    Then I should get a 301 status code
    And I should get a "Location" header of "https://gov.uk/"

  Scenario: Check redirect from bare domain to www.gov.uk is working for HTTPS and has HSTS enabled
    When I visit "https://gov.uk/" without following redirects
    Then I should get a 301 status code
    And I should get a "Location" header of "https://www.gov.uk/"
    And I should get a "Strict-Transport-Security" header of "max-age=63072000; preload"

  Scenario: Check www.gov.uk redirect from HTTP to HTTPS is working
    When I visit "http://www.gov.uk/" without following redirects
    Then I should get a 301 status code
    And I should get a "Location" header of "https://www.gov.uk/"

  Scenario: Check redirect from service domain to GOV.UK has HSTS enabled
    When I visit "https://service.gov.uk/" without following redirects
    Then I should get a 302 status code
    And I should get a "Location" header of "https://www.gov.uk"
    And I should get a "Strict-Transport-Security" header of "max-age=63072000; includeSubDomains; preload"
