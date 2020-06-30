Feature: CSV preview
  Tests to check CSV previews in whitehall.

  Background:
    Given I am testing through the full stack
    And I force a varnish cache miss

  Scenario: Accessing a CSV preview
    When I visit "/government/uploads/system/uploads/attachment_data/file/214962/passport-impact-indicat.csv/preview"
    Then JavaScript should run without any errors
