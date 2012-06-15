Feature: Whitehall

  Scenario: Visiting whitehall
    Given the "whitehall" application has booted
    And I am testing through the full stack
    And I bypass the varnish cache
    Then I should be able to visit:
      | Path                          |
      | /government/                  |
      | /government/news-and-speeches |
      | /government/policy-topics     |
      | /government/publications      |
      | /government/consultations     |
      | /government/ministers         |
      | /government/organisations     |
      | /government/world             |
      | /government/search?q=foo      |
      | /BIS                          |
