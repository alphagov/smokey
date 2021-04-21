@app-search-api
Feature: Search API

  @notintegration
  Scenario: Check sitemap
    When I visit "/sitemap.xml"
    Then it should contain a link to at least one sitemap file
    And I should be able to get all the referenced sitemap files

  @local-network
  Scenario: Healthcheck
    Given I am testing "search-api" internally
    When I request "/healthcheck/ready"
    Then JSON is returned
    And I should see ""status":"ok""
