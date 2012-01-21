Feature: Varnish Cache

  @notnagios
  Scenario: check cache is working
    Given I am testing "frontend"
    When I visit "/homepage" twice
    Then I should get content from the cache
