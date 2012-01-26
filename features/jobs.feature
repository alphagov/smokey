Feature: Jobs

  @pending
  Scenario: check jobs loads
    Given I am testing "jobs"
    Then I should be able to visit:
      | Path                                |
      | /job-search                         |
      | /job-search/search?location=CB21NB  |
