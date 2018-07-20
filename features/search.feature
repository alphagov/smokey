Feature: Search

  Background:
    Given I am testing through the full stack
    And I force a varnish cache miss for search

  @high
  Scenario: check search results for tax
    When I search for "tax"
    Then I should see some search results
    And the search results should be unique

  @high
  Scenario: check search results for passport
    When I search for "passport"
    Then I should see some search results
    And the search results should be unique

  @high
  Scenario: check search results for universal credit
    When I search for "universal credit"
    Then I should see some search results
    And the search results should be unique

  @normal
  Scenario: check organisation filtering
    When I search for "policy"
    Then I should see organisations in the organisation filter

  @normal @notintegration
  Scenario: check sitemap
    When I visit "/sitemap.xml"
    Then it should contain a link to at least one sitemap file
    And I should be able to get all the referenced sitemap files

  @high
  Scenario: malicious actor inputs malicious code to effect XSS attack
    When I search for "<script>alert(document.cookie)</script>"
    Then I see the code returned in the page
