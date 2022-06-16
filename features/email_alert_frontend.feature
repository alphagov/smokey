@app-email-alert-frontend @replatforming
Feature: Email Alert Frontend
  Scenario: Check the feedback component loads
    When I visit "/email/manage/authenticate"
    And I confirm it is rendered by "email-alert-frontend"
    And I click to report a problem with the page
    Then I see the report a problem form
    When I close the open feedback form
    And I click to say the page is not useful
    Then I see the email survey signup form
    When I close the open feedback form
    And I click to say the page is useful
    Then I see the feedback confirmation message
