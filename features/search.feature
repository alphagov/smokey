Feature: Search

  @high
  Scenario: check search loads
    Given I am testing through the full stack
    And I force a varnish cache miss
    Then I should be able to visit:
      | Path            |
      | /search         |
      | /search?q=tax   |

  @high
  Scenario: check search results on unified search
    Given I am testing through the full stack
    And I force a varnish cache miss
    When I search for "tax" using unified search
    Then I should see some search results

  @normal
  Scenario: check organisation filtering on unified search
    Given I am testing through the full stack
    And I force a varnish cache miss
    When I search for "policy" using unified search
    Then I should see organisations in the unified organisation filter

  @normal
  Scenario: check sitemap
    Given I am testing through the full stack
    And I force a varnish cache miss
    When I get the sitemap index
    Then It should contain a link to at least one sitemap file
    And I should be able to get all the referenced sitemap files
