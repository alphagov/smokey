Feature: Varnish Cache

  @pending
  Scenario: check all cache boxes are working
    When I visit some key urls on "<environment>-cache"
    And I visit some key urls on "<environment>-cache-1"
    And I visit some key urls on "<environment>-cache-2"
    Then every visit should get a success response
