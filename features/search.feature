Feature: Search

  Scenario: check search loads
    Given I am testing "search"
    Then I should be able to visit:
      | Path           |
      | /search        |
      | /search?q=tax  |
