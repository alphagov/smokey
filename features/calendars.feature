Feature: Calendars

  Background:
    Given I am testing through the full stack
    And I force a varnish cache miss

  @normal
  Scenario: check calendars loads
    Then I should be able to visit:
      | Path                       |
      | /when-do-the-clocks-change |
      | /bank-holidays             |

  @normal
  Scenario: check alternative formats are available
    Then I should be able to visit:
      | Path                                           |
      | /when-do-the-clocks-change/united-kingdom.json |
      | /when-do-the-clocks-change/united-kingdom.ics  |

  @normal
  Scenario: check bank holidays JSON format is consistent
    When I request "/bank-holidays.json"
    Then JSON is returned
