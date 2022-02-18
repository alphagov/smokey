@app-search-api
Feature: Search API
  Scenario: Check sitemap
    Given I am testing through the full stack
    And I force a varnish cache miss
    When I visit "/sitemap.xml"
    Then it should contain a link to at least one sitemap file
    And I should be able to get all the referenced sitemap files
