@app-info-frontend @replatforming
Feature: Info Frontend

  Scenario: Check the frontend can talk to Content Store
    When I visit "/info/browse/benefits"
    Then I should see "Benefits"
