Feature: Redirect of gov.uk to www.gov.uk

  @high
  Scenario: Check redirect from bare domain to www.gov.uk is working for HTTP and has HSTS enabled
    When I visit "http://gov.uk/" without following redirects
    Then I should get a 301 status code
    And I should get a "Location" header of "https://gov.uk/"
    And I should get a "Strict-Transport-Security" header of "max-age=63072000; preload"

  @high
  Scenario: Check redirect from bare domain to www.gov.uk is working for HTTPS and has HSTS enabled
    When I visit "https://gov.uk/" without following redirects
    Then I should get a 301 status code
    And I should get a "Location" header of "https://www.gov.uk/"
    And I should get a "Strict-Transport-Security" header of "max-age=63072000; preload"

  @high
  Scenario: Check www.gov.uk redirect from HTTP to HTTPS is working and has HSTS enabled
    When I visit "http://www.gov.uk/" without following redirects
    Then I should get a 301 status code
    And I should get a "Location" header of "https://www.gov.uk/"
    And I should get a "Strict-Transport-Security" header of "max-age=31536000; preload"

  @normal
  Scenario: Check redirect from service domain to GOV.UK has HSTS enabled
    When I visit "https://service.gov.uk/" without following redirects
    Then I should get a 302 status code
    And I should get a "Location" header of "https://www.gov.uk"
    And I should get a "Strict-Transport-Security" header of "max-age=63072000; includeSubDomains; preload"
