Feature: Search

  Scenario: check search loads
    Given I am testing "search"
    Then I should be able to visit:
      | Path           |
      | /search        |
      | /search?q=tax  |

  Scenario: check we don't get lots of results for cheese
    Given I am testing "search"
    When I search for "cheese"
    Then I should receive no results

