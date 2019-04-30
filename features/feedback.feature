Feature: Feedback

  Background:
    Given I am testing through the full stack
    And I force a varnish cache miss

  @normal
  Scenario: Check the "Contact GOV.UK" page loads correctly
    When I visit "/contact/govuk"
    Then I should see "Contact GOV.UK"

  @high
  Scenario: Check malicious code does not execute
    When I visit "/contact/govuk"
    And I input malicious code in the email field
    Then I see the code returned in the page

  @normal
  Scenario: Check the FoI page loads correctly
    When I visit "/contact/foi"
    Then I should see "How to make a freedom of information (FOI) request"
