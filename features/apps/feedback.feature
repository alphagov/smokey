@app-feedback
Feature: Feedback

  @worksonmirror
  Scenario: Check the frontend can talk to Content Store
    When I visit "/contact/govuk"
    Then I should see "Contact GOV.UK"

  @notcloudfront
  Scenario: Check "is this page useful?" email survey
    When I visit "/"
    And I click to say the page is not useful
    And I submit the email survey signup form
    Then I see the feedback confirmation message
    And a request is sent to the feedback app
