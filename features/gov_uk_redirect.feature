Feature: Redirect of gov.uk to www.gov.uk

  Scenario: Check redirect from bare domain to www.gov.uk is working for HTTP
    Given I am testing "http://gov.uk"
    When I visit "/" without following redirects
    Then I should get a 301 status code
    And I should get a "Location" header of "https://gov.uk/"

  Scenario: Check redirect from bare domain to www.gov.uk is working for HTTPS and has HSTS enabled
    Given I am testing "https://gov.uk"
    When I visit "/" without following redirects
    Then I should get a 301 status code
    And I should get a "Location" header of "https://www.gov.uk/"
    And I should get a "Strict-Transport-Security" header of "max-age=63072000; preload"

  Scenario: Check www.gov.uk redirect from HTTP to HTTPS is working
    Given I am testing "http://www.gov.uk"
    When I visit "/" without following redirects
    Then I should get a 301 status code
    And I should get a "Location" header of "https://www.gov.uk/"

  Scenario: Check redirect from service domain to GOV.UK has HSTS enabled
    Given I am testing "https://service.gov.uk"
    When I visit "/" without following redirects
    Then I should get a 302 status code
    And I should get a "Location" header of "https://www.gov.uk"
    And I should get a "Strict-Transport-Security" header of "max-age=63072000; includeSubDomains; preload"
