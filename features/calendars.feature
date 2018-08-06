Feature: Calendars

  Background:
    Given I am testing through the full stack
    And I force a varnish cache miss

  @normal
  Scenario: Check calendars pages
    Then I should be able to visit:
      | Path                       |
      | /when-do-the-clocks-change |
      | /bank-holidays             |

  @normal
  Scenario: Check alternative formats are available
    Then I should be able to visit:
      | Path                                           |
      | /when-do-the-clocks-change/united-kingdom.json |
      | /when-do-the-clocks-change/united-kingdom.ics  |

  @normal
  Scenario: Check bank holidays JSON format is consistent
    When I request "/bank-holidays.json"
    Then JSON is returned
