Feature: Router

  @high
  Scenario: Router loads home page
    Given I am testing through the full stack
    And I force a varnish cache miss
    Then I should be able to visit:
      | Path      |
      | /         |

  @normal
  Scenario: Department short URLs redirect correctly
    Given I am testing through the full stack
    And I force a varnish cache miss
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
