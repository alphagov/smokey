Feature: Search

  @high
  Scenario Outline: check search results
    Given I am testing through the full stack
    And I force a varnish cache miss
    When I search for "<query>"
    Then I should see some search results
    And the search results should have different titles

    Examples:
      | query                           |
      | universal credit                |
      | personal tax account            |
      | apprenticeships                 |
      | contact                         |
      | car tax                         |
      | passport                        |
      | claim your state pension online |
      | SORN                            |
      | SA100                           |
      | change of address               |


  @normal
  Scenario: check organisation filtering
    Given I am testing through the full stack
    And I force a varnish cache miss
    When I search for "policy"
    Then I should see organisations in the organisation filter

  @normal
  Scenario: check sitemap
    Given I am testing through the full stack
    And I force a varnish cache miss
    When I get the sitemap index
    Then It should contain a link to at least one sitemap file
    And I should be able to get all the referenced sitemap files
