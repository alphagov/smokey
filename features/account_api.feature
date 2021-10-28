@app-account-api
Feature: Account API
  @notintegration @notstaging @notproduction @app-frontend @app-collections @app-finder-frontend
  Scenario Outline: Signing in
    Given I am testing through the full stack
    And I force a varnish cache miss
    When I visit "<Path>"
    Then I should see "Sign in"
    When I click on the link "Sign in"
    Then I should see "Sign in to your GOV.UK account"
    When I sign in to my GOV.UK account
    Then I should see "Sign out"

    Examples:
      | Path                                                                      |
      | /brexit                                                                   |
      | /transition-check/results?c[]=living-uk&c[]=nationality-uk&c[]=working-uk |
