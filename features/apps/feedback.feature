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
    Then I see a survey link
