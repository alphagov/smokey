@app-content-data-admin
Feature: Content Data Admin
  Scenario: Check log in to content-data-admin
    When I go to the "content-data-admin" landing page
    And I try to login as a user
    And I go to the "content-data-admin" landing page
    Then I should see "Content Data"

  Scenario: Check admin can talk to Content Data API
    When I try to login as a user
    And I visit "/metrics/government/organisations/government-digital-service" on the "content-data-admin" application
    Then I should see "Page data"
