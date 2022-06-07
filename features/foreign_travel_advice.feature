@replatforming
Feature: Foreign Travel Advice

  Background:
    Given I force a varnish cache miss

  Scenario: Check the index page loads correctly
    When I visit "/foreign-travel-advice"
    Then I should see "Foreign travel advice"
    And I should see "Afghanistan"
    And I should see "Luxembourg"

  Scenario: Check a country page loads correctly
    When I visit "/foreign-travel-advice/luxembourg"
    Then I should see "Luxembourg"
    And I should see "Summary"

  Scenario: Email signup from foreign travel advice
    When I visit "/foreign-travel-advice/turkey"
    And I click on the link "Get email alerts"
    And I click on the button "Continue"
    Then I should see "How often do you want to get emails?"
