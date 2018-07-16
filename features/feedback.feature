Feature: Feedback

  Background:
    Given I am testing through the full stack
    And I force a varnish cache miss

  @normal
  Scenario: The "Contact GOV.UK" page
    When I visit "/contact/govuk"
    Then I should see "Contact GOV.UK"

  @high
  Scenario: malicious actor inputs code to carry out XSS attack
    When I visit "contact/govuk"
    And I input malicious code in the email field
    Then I see the code returned in the page
