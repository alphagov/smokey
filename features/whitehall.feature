Feature: Whitehall
  This is the Inside Government application that powers
  www.gov.uk/government and the detailed guidance format type.

  @normal
  Scenario: Government publishing section on GOV.UK homepage
    Given I am testing through the full stack
    And I force a varnish cache miss
    Then I should see the departments and policies section on the homepage

  @notintegration
  Scenario: There should be no authentication for Whitehall
    Given I am testing through the full stack
    And I force a varnish cache miss
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

  @disabled_in_icinga
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
  Scenario: Department short URLs redirect correctly
    Given I am testing through the full stack
    Then I should be redirected when I try to visit:
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
      | /treasury                 |
      | /wales-office             |

  @local-network
  @low
  @benchmarking
  Scenario: Whitehall frontend website should be fast
    Given I am benchmarking
    And I am testing through the full stack
    And I force a varnish cache miss
    When I visit "/government/how-government-works"
    Then the elapsed time should be less than 2 seconds

  @normal
  @benchmarking
  Scenario: Whitehall offers a world location API
    Given I am benchmarking
    And I am testing through the full stack
    And I force a varnish cache miss
    When I visit "/api/world-locations"
    Then the elapsed time should be less than 2 seconds

  @normal
  Scenario: Whitehall assets are served
    Given I am testing through the full stack
    When I request "/government/uploads/system/uploads/attachment_data/file/618167/government_dietary_recommendations.pdf"
    Then I should get a 200 status code

  @normal
  @benchmarking
  Scenario: National statistics release calendar is served
    Given I am testing through the full stack
    And I force a varnish cache miss
    And I am benchmarking
    When I visit "/government/statistics/announcements"
    Then I should get a 200 status code
    And the elapsed time should be less than 2 seconds
