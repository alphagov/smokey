@replatforming @app-whitehall
Feature: Whitehall
  Scenario: Check the frontend can talk to Content Store
    When I request "/government/ministers"
    Then I should see "Ministers by department"

  Scenario: Check whitehall assets are redirected to and served from the asset host
    When I request an attachment
    Then I should be redirected to the asset host
    And the attachment should be served successfully

  Scenario: Check the frontend can talk to Asset Manager
    When I visit "/government/uploads/system/uploads/attachment_data/file/214962/passport-impact-indicat.csv/preview"
    Then JavaScript should run without any errors

  Scenario: Check the feedback component loads
    When I visit "/world"
    And I confirm it is rendered by "whitehall"
    And I click to report a problem with the page
    Then I see the report a problem form
    When I close the open feedback form
    And I click to say the page is not useful
    Then I see the email survey signup form
    When I close the open feedback form
    And I click to say the page is useful
    Then I see the feedback confirmation message

  @app-publishing-api
  Scenario: Can log in to whitehall
    When I go to the "whitehall-admin" landing page
    And I try to login as a user
    And I go to the "whitehall-admin" landing page
    Then I should see "GOV.UK Whitehall"
    And I should see "Logout"
    And I should see "Dashboard"
    And I should see "My draft documents"
