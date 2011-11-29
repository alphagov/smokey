Feature: Jobs

  Scenario: check jobs loads
    Given I am testing "jobs"
    Then I should be able to visit:
      | /job-search                         |
      | /job-search/search?location=CB21NB  |
