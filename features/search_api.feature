Feature: Search API

  @notintegration
  Scenario: Check sitemap
    When I visit "/sitemap.xml"
    Then it should contain a link to at least one sitemap file
    And I should be able to get all the referenced sitemap files
