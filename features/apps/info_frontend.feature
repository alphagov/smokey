@app-info-frontend @replatforming
Feature: Info Frontend

  Scenario: Check the frontend can talk to Content Store
    When I visit "/info/sign-in-universal-credit"
    Then I should see "The user need for this page"

  Scenario: Check the feedback component loads
    When I visit "/info/vat-rates"
    And I confirm it is rendered by "info-frontend"
    And I click to report a problem with the page
    Then I see the report a problem form
    When I close the open feedback form
    And I click to say the page is not useful
    Then I see the email survey signup form
    When I close the open feedback form
    And I click to say the page is useful
    Then I see the feedback confirmation message
