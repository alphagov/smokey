Feature: Whitehall

  Scenario: Visiting whitehall
    Given I am testing "whitehall"
    Then I should be able to visit:
      | Path                          |
      | /government/                  |
      | /government/news-and-speeches |
      | /government/policy-areas      |
      | /government/publications      |
      | /government/consultations     |
      | /government/ministers         |
      | /government/organisations     |
      | /government/search?q=foo      |
