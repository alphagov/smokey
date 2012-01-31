Feature: Varnish Cache

  @notnagios
  Scenario: check cache is working
    Given I am testing "frontend"
    When I visit "/" 6 times
    Then I should get content from the cache
