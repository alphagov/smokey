Feature: Whitehall

  Scenario: Visiting whitehall
    Given the "whitehall" application has booted
    And I am testing through the full stack
    And I force a varnish cache miss
    Then I should be able to view policies
    And I should be able to view publications
    Then I should be able to visit:
      | Path                             |
      | /specialist/                     |
      | /government/                     |
      | /government/search?q=search-term |
      | /government/announcements        |
      | /government/policy-topics        |
      | /government/consultations        |
      | /government/ministers            |
      | /government/organisations        |
      | /government/world                |
      | /bis                             |

  Scenario: Quickly loading the whitehall home page
    Given the "whitehall" application has booted
    And I am benchmarking
    And I am testing through the full stack
    When I visit "/government/"
    Then the elapsed time should be less than 2 seconds

  Scenario: Whitehall can connect to the database
    Given the "whitehall" application has booted
    And I am testing through the full stack
    And I force a varnish cache miss
    When I visit "/healthcheck"
    Then I should get a 200 status code
