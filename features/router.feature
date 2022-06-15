@replatforming @app-router
Feature: Router

  Background:
    Given I am testing through the full stack
    And I force a varnish cache miss

  # TODO: REMOVE this test as it is a duplicate.
  #
  # Duplicate of "Check homepage content type and charset". The
  # features should be combined to test response code and headers.
  #
  Scenario: Check the router loads home page
    Then I should be able to visit:
      | Path      |
      | /         |

  # TODO: REMOVE this test as it is a duplicate.
  #
  # Duplicate of "Check redirects work".
  #
  Scenario: Check department short URLs redirect correctly
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
