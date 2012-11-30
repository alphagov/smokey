Feature: Whitehall

  @notnagios
  Scenario: Visiting whitehall
    Given the "whitehall" application has booted
    And I am testing through the full stack
    And I force a varnish cache miss
    Then I should be able to view policies
    And I should be able to view publications
    Then I should be able to visit:
      | Path                             |
      | /government/                     |
      | /government/announcements        |
      | /government/policy-topics        |
      | /government/consultations        |
      | /government/ministers            |
      | /government/organisations        |
      | /government/world                |

  @medium
  Scenario: Department short URLs work correctly
    Given I am testing through the full stack
    Then I should be able to visit:
          | Path                   |
          | /bis                   |
          | /brac                  |
          | /cabinetoffice         |
          | /communities           |
          | /dclg                  |
          | /defra                 |
          | /dfid                  |
          | /dft                   |
          | /dh                    |
          | /dsa                   |
          | /fco                   |
          | /hmrc                  |
          | /mod                   |
          | /moj                   |
          | /pins                  |
          | /planning-inspectorate |
          | /transport             |

  @local-network
  @high
  Scenario: Whitehall frontend can connect to the database
    Given the "whitehall" application has booted
    And I am testing through the full stack
    And I force a varnish cache miss
    When I visit "/healthcheck" on the "whitehall-frontend" application
    Then I should get a 200 status code

  @local-network
  @medium
  Scenario: Whitehall admin can connect to the database
    Given the "whitehall" application has booted
    And I am testing through the full stack
    And I force a varnish cache miss
    When I visit "/healthcheck" on the "whitehall-admin" application
    Then I should get a 200 status code

  @local-network
  @medium
  Scenario: Whitehall frontend database should be fast
    Given the "whitehall" application has booted
    And I am benchmarking
    And I am testing through the full stack
    And I force a varnish cache miss
    When I visit "/healthcheck" on the "whitehall-frontend" application
    Then the elapsed time should be less than 1 second

  @local-network
  @low
  Scenario: Whitehall frontend website should be fast
    Given the "whitehall" application has booted
    And I am benchmarking
    And I am testing through the full stack
    And I force a varnish cache miss
    When I visit "/government/" on the "whitehall-frontend" application
    Then the elapsed time should be less than 2 seconds

  @local-network
  @low
  Scenario: Whitehall admin database should be fast
    Given the "whitehall" application has booted
    And I am benchmarking
    And I am testing through the full stack
    And I force a varnish cache miss
    When I visit "/healthcheck" on the "whitehall-admin" application
    Then the elapsed time should be less than 1 second
