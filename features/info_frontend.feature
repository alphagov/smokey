@app-info-frontend @replatforming
Feature: Info Frontend

  Scenario: Check the info page for the benefits mainstream browse page
    When I visit "/info/browse/benefits"
    Then I should see "Benefits"
