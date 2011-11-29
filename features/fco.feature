Feature: FCO

  Scenario: check fco loads
    Given I am testing "fco"
    Then I should be able to visit:
      | Path                             |
      | /travel-advice                   |
      | /travel-advice/countries/somalia |
