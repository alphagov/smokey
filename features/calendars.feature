Feature: Calendars

  Scenario: check calendars loads
    Given the "calendars" application has booted
    And I am testing through the full stack
    Then I should be able to visit:
      | Path                       |
      | /when-do-the-clocks-change |
      | /bank-holidays             |
