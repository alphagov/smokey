@replatforming @app-whitehall
Feature: CSV preview
  Tests to check CSV previews in whitehall.

  Scenario: Accessing a CSV preview
    When I visit "/government/uploads/system/uploads/attachment_data/file/214962/passport-impact-indicat.csv/preview"
    Then JavaScript should run without any errors
