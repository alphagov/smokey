Feature: Whitehall

  Scenario: Visiting whitehall
    Given I am testing "whitehall"
    Then I should be able to visit:
      | Path                          |
      | /government/                  |
      | /government/news-and-speeches |
      | /government/policy-topics     |
      | /government/publications      |
      | /government/consultations     |
      | /government/ministers         |
      | /government/organisations     |
      | /government/search?q=foo      |

  Scenario: Blocking admin access through the main site
    Given I am testing www.gov.uk
    When visting "/government/admin" should respond with 404 Not Found