Feature: Services and information pages

  @high
  Scenario: Check Services and Information pages
    Given I am testing through the full stack
    And I force a varnish cache miss
    When I visit "/government/organisations/hm-revenue-customs/services-information"
    Then I see links to pages per topic
