Feature: Search

  @high
  Scenario: check search results for tax
    Given I am testing through the full stack
    And I force a varnish cache miss
    When I search for "tax"
    Then I should see some search results
    And the search results should be unique

  @high
  Scenario: check search results for passport
    Given I am testing through the full stack
    And I force a varnish cache miss
    When I search for "passport"
    Then I should see some search results
    And the search results should be unique

  @high
  Scenario: check search results for universal credit
    Given I am testing through the full stack
    And I force a varnish cache miss
    When I search for "universal credit"
    Then I should see some search results
    And the search results should be unique

  @normal
  Scenario: check organisation filtering
    Given I am testing through the full stack
    And I force a varnish cache miss
    When I search for "policy"
    Then I should see organisations in the organisation filter

  @normal @notintegration
  Scenario: check sitemap
    Given I am testing through the full stack
    And I force a varnish cache miss
    When I get the sitemap index
    Then It should contain a link to at least one sitemap file
    And I should be able to get all the referenced sitemap files

  @high
  Scenario: malicious actor inputs malicious code to effect XSS attack
    Given I am testing through the full stack
    And I force a varnish cache miss
    When I search for "<script>alert(document.cookie)</script>"
    Then I see the code returned in the page
