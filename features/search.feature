Feature: Search

  @high
  Scenario: check search loads
    Given I am testing through the full stack
    And the "frontend" application has booted
    And I force a varnish cache miss
    Then I should be able to visit:
      | Path            |
      | /search         |
      | /search?q=tax   |

  Scenario: check search results
    Given I am testing through the full stack
    And the "frontend" application has booted
    And I force a varnish cache miss
    When I search for "tax"
    Then I should see some GOV.UK results

  Scenario: check organisation filtering
    Given I am testing through the full stack
    And the "frontend" application has booted
    And I force a varnish cache miss
    When I search for "policy"
    Then I should see organisations in the organisation filter

  Scenario: check sitemap
    Given I am testing through the full stack
    And I force a varnish cache miss
    When I get the sitemap index
    Then It should contain a link to at least one sitemap file
    And I should be able to get all the referenced sitemap files
