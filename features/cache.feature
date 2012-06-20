Feature: Varnish Cache

  @notnagios
  Scenario: check cache is working
    Given I am testing through the full stack
    When I visit "/" 6 times
    Then I should get content from the cache

  Scenario: check all cache boxes are working
    When I visit some key urls on "<environment>-cache"
    And I visit some key urls on "<environment>-cache-1"
    And I visit some key urls on "<environment>-cache-2"
    Then every visit should get a success response