@app-manuals-frontend @replatforming
Feature: Manuals Frontend

  Background:
    Given I am testing through the full stack
    And I force a varnish cache miss

  @not-replatforming
  Scenario: Check manuals load
    Then I should be able to visit:
      | Path                                       |
      | /guidance/content-design/planning-content  |
      | /hmrc-internal-manuals/pensions-tax-manual |
