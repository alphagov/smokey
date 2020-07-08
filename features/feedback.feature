Feature: Feedback

  Background:
    Given I am testing through the full stack
    And I force a varnish cache miss

  Scenario: Check the "Contact GOV.UK" page loads correctly
    When I visit "/contact/govuk"
    Then I should see "Contact GOV.UK"

  Scenario: Check malicious code does not execute
    When I visit "/contact/govuk"
    And I input malicious code in the email field
    Then I see the code returned in the page

  Scenario: Check the FoI page loads correctly
    When I visit "/contact/foi"
    Then I should see "How to make a freedom of information (FOI) request"

  Scenario: Check "is this page useful?" email survey
    When I visit "/"
    And I click to say the page is not useful
    And I submit the email survey signup form
    Then I see a signup confirmation message
    And a request is sent to the feedback app
