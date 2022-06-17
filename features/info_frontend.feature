@app-info-frontend @replatforming
Feature: Info Frontend

  Scenario: Check the frontend can talk to Content Store
    When I visit "/info/sign-in-universal-credit"
    Then I should see "The user need for this page"
