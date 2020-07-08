@aws
Feature: Frontend

  Background:
    Given I am testing through the full stack
    And I force a varnish cache miss

  Scenario: Check robots.txt
    When I request "/robots.txt"
    Then I should see "User-agent:"

  Scenario: Check transactions load
    When I visit "/apply-renew-passport"
    Then I should see "UK passport"

  Scenario: Check help page loads correctly
    When I visit "/help"
    Then I should see "Help using GOV.UK"

  Scenario: Check homepage content type and charset
    When I request "/"
    Then I should get a "Content-Type" header of "text/html; charset=utf-8"

  @pending
  Scenario: Check homepage sends an event to Google Analytics
    When I visit "/"
    Then the page view should be tracked

  Scenario: Check 404 page content type and charset
    When I visit a non-existent page
    Then I should get a "Content-Type" header of "text/html; charset=utf-8"

  Scenario: Check licences load
    When I visit "/busking-licence"
    Then I should see "Busking licence"
     And I should see an input field for postcode
    When I try to post to "/busking-licence" with "postcode=E20+2ST"
    Then I should see "Busking licence"

  Scenario: Check local transactions load
    When I visit "/pay-council-tax"
    Then I should see "Pay your Council Tax"
    When I try to post to "/pay-council-tax" with "postcode=WC2B+6SE"
    Then I should see "Camden"

  Scenario: Check "find my nearest" returns results
    When I visit "/ukonline-centre-internet-access-computer-training"
    And I should see "Online Centres Network"
    When I try to post to "/ukonline-centre-internet-access-computer-training" with "postcode=WC2B+6NH"
    Then I should see "Holborn Library"

  Scenario: Check redirects work
    When I visit "/workplacepensions"
    Then I should be at a location path of "/workplace-pensions"

  Scenario: Check calendars pages
    Then I should be able to visit:
      | Path                       |
      | /when-do-the-clocks-change |
      | /bank-holidays             |

  Scenario: Check alternative formats are available
    Then I should be able to visit:
      | Path                                           |
      | /when-do-the-clocks-change/united-kingdom.json |
      | /when-do-the-clocks-change/united-kingdom.ics  |

  Scenario: Check bank holidays JSON format is consistent
    When I request "/bank-holidays.json"
    Then JSON is returned
