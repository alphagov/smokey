@replatforming @app-whitehall
Feature: Whitehall
  Tests for the whitehall application that powers some pages under
  www.gov.uk/government and www.gov.uk/world.

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
