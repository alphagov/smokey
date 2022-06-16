@replatforming @app-service-manual-frontend
Feature: Service Manual Frontend

  Scenario: Check the frontend can talk to Content Store
    When I visit "/service-manual"
    Then I should see "Service Manual"

  Scenario: Check the feedback component loads
    When I visit "/service-manual"
    And I confirm it is rendered by "service-manual-frontend"
    And I click to report a problem with the page
    Then I see the report a problem form
    When I close the open feedback form
    And I click to say the page is not useful
    Then I see the email survey signup form
    When I close the open feedback form
    And I click to say the page is useful
    Then I see the feedback confirmation message
