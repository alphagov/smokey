Feature: redirector
  @urgent
  Scenario: Redirect from directgov availability
    Given I am benchmarking
    When I visit "http://aka.direct.gov.uk/" without following redirects
    Then I should get a 301 status code
    And I should get a location of "https://www.gov.uk"
    And the elapsed time should be less than 1 seconds

  @urgent
  Scenario: Redirect from directgov homepage availability
    Given I am benchmarking
    When I visit "http://aka.direct.gov.uk/en/index.htm" without following redirects
    Then I should get a 301 status code
    And I should get a location of "https://www.gov.uk"
    And the elapsed time should be less than 1 seconds

  @urgent
  Scenario: Redirect from directgov search results availability
    Given I am benchmarking
    When I visit "http://aka.direct.gov.uk/en/AdvancedSearch/Searchresults/index.htm?fullText=test" without following redirects
    Then I should get a 301 status code
    And I should get a location of "https://www.gov.uk/search"
    And the elapsed time should be less than 1 seconds

  @urgent
  Scenario: Redirect from businesslink availability
    Given I am benchmarking
    When I visit "http://aka.businesslink.gov.uk/" without following redirects
    Then I should get a 301 status code
    And I should get a location of "https://www.gov.uk"
    And the elapsed time should be less than 1 seconds

  @urgent
  Scenario: Redirect from businesslink homepage availability
    Given I am benchmarking
    When I visit "http://aka.businesslink.gov.uk/bdotg/action/home?domain=www.businesslink.gov.uk&target=http://www.businesslink.gov.uk/" without following redirects
    Then I should get a 301 status code
    And I should get a location of "https://www.gov.uk"
    And the elapsed time should be less than 1 seconds

  @urgent
  Scenario: Redirect from businesslink search results availability
    Given I am benchmarking
    When I visit "http://aka.businesslink.gov.uk/bdotg/action/searchBasicMode?resultPage=1&expression=test" without following redirects
    Then I should get a 301 status code
    And I should get a location of "https://www.gov.uk/search"
    And the elapsed time should be less than 1 seconds
