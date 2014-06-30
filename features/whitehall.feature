Feature: Whitehall
  This is the Inside Government application that powers
  www.gov.uk/government and the detailed guidance format type.

  @normal
  Scenario: Government publishing section on GOV.UK homepage
    Given I am testing through the full stack
    And I force a varnish cache miss
    Then I should see the departments and policies section on the homepage

  @notpreview
  Scenario: There should be no authentication for Whitehall
    Given I am testing through the full stack
    And I force a varnish cache miss
    And I am not an authenticated user
    Then I should be able to view policies
    And I should be able to view announcements
    And I should be able to view publications
    Then I should be able to visit:
      | Path                      |
      | /government/topics        |
      | /government/consultations |
      | /government/ministers     |
      | /government/organisations |
      | /government/world         |

  @normal
  Scenario: Searching for an existing consultation on whitehall via elastic search
    Given I am testing through the full stack
    And I force a varnish cache miss
    When I do a whitehall search for "Assessing radioactive waste disposal sites"
    Then I should see "Assessing radioactive waste disposal sites"

  @notnagios
  Scenario: Feeds should be available for documents
    Given I am testing through the full stack
    And I force a varnish cache miss
    Then I should be able to visit:
      | Path                           |
      | /government/announcements.atom |
      | /government/publications.atom  |

  @normal
  Scenario: Visiting whitehall
    Given I am testing through the full stack
    And I force a varnish cache miss
    Then I should be able to view policies
    And I should be able to view announcements
    And I should be able to view publications
    Then I should be able to visit:
      | Path                             |
      | /government/how-government-works |
      | /government/get-involved         |
      | /government/topics               |
      | /government/consultations        |
      | /government/ministers            |
      | /government/organisations        |
      | /government/world                |

  @normal
  Scenario: Department short URLs work correctly
    Given I am testing through the full stack
    Then I should be able to visit:
      | Path                      |
      | /ago                      |
      | /airports-commission      |
      | /bis                      |
      | /brac                     |
      | /cabinetoffice            |
      | /cabinet-office           |
      | /communities              |
      | /dclg                     |
      | /dcms                     |
      | /decc                     |
      | /defra                    |
      | /dfe                      |
      | /dfid                     |
      | /dft                      |
      | /dh                       |
      | /dsa                      |
      | /dwp                      |
      | /fco                      |
      | /hmrc                     |
      | /home-office              |
      | /mod                      |
      | /moj                      |
      | /nio                      |
      | /oag                      |
      | /office-for-life-sciences |
      | /phe                      |
      | /pins                     |
      | /planning-inspectorate    |
      | /scotland-office          |
      | /transport                |
      | /treasury                 |
      | /wales-office             |

  @local-network
  @high
  Scenario: Whitehall frontend can connect to the database
    Given I am testing through the full stack
    And I force a varnish cache miss
    When I visit "/healthcheck" on the "whitehall-frontend" application
    Then I should get a 200 status code

  @local-network
  @normal
  Scenario: Whitehall admin can connect to the database
    Given I am testing through the full stack
    And I force a varnish cache miss
    When I visit "/healthcheck" on the "whitehall-admin" application
    Then I should get a 200 status code

  @local-network
  @normal
  Scenario: Whitehall frontend database should be fast
    Given I am benchmarking
    And I am testing through the full stack
    And I force a varnish cache miss
    When I visit "/healthcheck" on the "whitehall-frontend" application
    Then the elapsed time should be less than 1 second

  @local-network
  @low
  Scenario: Whitehall frontend website should be fast
    Given I am benchmarking
    And I am testing through the full stack
    And I force a varnish cache miss
    When I visit "/government/how-government-works" on the "whitehall-frontend" application
    Then the elapsed time should be less than 2 seconds

  @local-network
  @low
  Scenario: Whitehall admin database should be fast
    Given I am benchmarking
    And I am testing through the full stack
    And I force a varnish cache miss
    When I visit "/healthcheck" on the "whitehall-admin" application
    Then the elapsed time should be less than 1 second

  @normal
  Scenario: Whitehall offers a world location API
    Given I am benchmarking
    And I am testing through the full stack
    And I force a varnish cache miss
    When I visit "/api/world-locations" on the "whitehall-admin" application
    Then the elapsed time should be less than 2 seconds

  @normal
  Scenario: Whitehall assets are served
    Given I am testing through the full stack
    When I visit "/government/uploads/system/uploads/attachment_data/file/32409/11-944-higher-education-students-at-heart-of-system.pdf"
    Then I should get a 200 status code

  @normal
  Scenario: Whitehall related google analytics custom vars added through slimmer are present
    Given I am testing through the full stack
    When I visit "/government/organisations/prime-ministers-office-10-downing-street"
    Then google analytics custom vars set by slimmer exist
