@aws
Feature: Content Data Admin
  Tests for the Content Data Admin application, which provides
  publishers with data about the content they manage

  Scenario: Can access the Content Data Admin index page
    When I go to the "content-data-admin" landing page
    And I try to login as a user
    And I go to the "content-data-admin" landing page
    Then I should see "Content Data"
    And I should see "Log out"

  Scenario: Can access a Content Data Admin metrics page
    When I try to login as a user
    And I visit "/metrics/government/organisations/government-digital-service" on the "content-data-admin" application
    Then I should see "Page data"
    And I should see "Organisation"
