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

  # Scenarios for tabbed search
  # TODO: remove these once unified search has been released
  
  Scenario: check search results on tabbed search
    Given I am testing through the full stack
    And the "frontend" application has booted
    And I force a varnish cache miss
    When I search for "tax" using tabbed search
    Then I should see some GOV.UK results

  Scenario: check organisation filtering on tabbed search
    Given I am testing through the full stack
    And the "frontend" application has booted
    And I force a varnish cache miss
    When I search for "policy" using tabbed search
    Then I should see organisations in the organisation filter

  # Scenarios for unified search

  Scenario: check search results on unified search
    Given I am testing through the full stack
    And the "frontend" application has booted
    And I force a varnish cache miss
    When I search for "tax" using unified search
    Then I should see some GOV.UK results

  Scenario: check organisation filtering on unified search
    Given I am testing through the full stack
    And the "frontend" application has booted
    And I force a varnish cache miss
    When I search for "policy" using unified search
    Then I should see organisations in the unified organisation filter

  Scenario: check sitemap
    Given I am testing through the full stack
    And I force a varnish cache miss
    When I get the sitemap index
    Then It should contain a link to at least one sitemap file
    And I should be able to get all the referenced sitemap files
