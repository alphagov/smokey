Feature: CDN
  @notcloudfront
  Scenario: Check all A/B test variants work
    Given I consent to cookies
    When multiple new users visit "/help/ab-testing"
    Then we have shown them all versions of the A/B test

  @notcloudfront
  Scenario: Check an A/B test is persistent
    Given I consent to cookies
    And I do not have any A/B testing cookies set
    When I visit "/help/ab-testing"
    Then I am assigned to a test bucket
    And I can see the bucket I am assigned to
    And the bucket is reported to Google Analytics
    And I stay on the same bucket when I keep visiting "/help/ab-testing"

  @notcloudfront
  Scenario: Check caching behaviour for POST requests
    When I try to post to "/find-local-council" with "postcode=E1+8QS" without following redirects
    Then I should not hit the cache
    And I should get a 302 status code

  @notcloudfront
  Scenario: Check caching behaviour for GET requests
    When I request "/"
    Then I should hit the cache

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
