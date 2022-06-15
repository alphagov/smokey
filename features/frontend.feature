@replatforming @app-frontend
Feature: Frontend

  Background:
    Given I am testing through the full stack
    And I force a varnish cache miss

  Scenario: Check robots.txt
    When I request "/robots.txt"
    Then I should see "User-agent:"

  # TODO: REMOVE this test as it does not meet the eligibility
  # criteria in docs/writing-tests.md.
  #
  # - Covers site-wide config: N (not applicable)
  # - Targets data transfer: N (already covered)
  # - Second critical check: N (arbitrary page)
  #
  # Data transfer with Content Store is implicitly covered by
  # "Check homepage content type and charset".
  #
  # Also tested in app [^1].
  #
  # [^1]: https://github.com/alphagov/frontend/blob/a40ba988c58dd882d841a6f1d82d5b894939fdc5/test/integration/transaction_test.rb
  #
  Scenario: Check transactions load
    When I visit "/apply-renew-passport"
    Then I should see "UK passport"

  Scenario: Check help page loads correctly
    When I visit "/help"
    Then I should see "Help using GOV.UK"

  Scenario: Check homepage content type and charset
    When I request "/"
    Then I should get a "Content-Type" header of "text/html; charset=utf-8"

  Scenario: Check homepage sends an event to Google Analytics
    When I visit "/"
    And I consent to cookies
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

  Scenario: Check electoral pages load
    When I visit "/contact-electoral-registration-office"
    Then I should see "Electoral Registration Office"
    When I visit "/contact-electoral-registration-office?postcode=sw1a+1aa"
    Then I should see "Get help with electoral registration"
    When I visit "/contact-electoral-registration-office?postcode=WV148TU"
    Then I should see "Choose your address"

  Scenario: Check "find my nearest" returns results
    When I visit "/ukonline-centre-internet-access-computer-training"
    And I should see "Online Centres Network"
    When I try to post to "/ukonline-centre-internet-access-computer-training" with "postcode=WC2B+6NH"
    Then I should see "Holborn Library"

  Scenario: Check redirects work
    When I visit "/workplacepensions"
    Then I should be at a location path of "/workplace-pensions"

  # TODO: REMOVE this test as it does not meet the eligibility
  # criteria in docs/writing-tests.md.
  #
  # - Covers site-wide config: N (not applicable)
  # - Targets data transfer: N (already covered)
  # - Second critical check: N (arbitrary page)
  #
  # Data transfer with Content Store is implicitly covered by
  # "Check homepage content type and charset".
  #
  # Also tested in app [^1][^2].
  #
  # [^1]: https://github.com/alphagov/frontend/blob/d98da1aa0f62eb12b57af37f45bd9d728d1097ba/test/integration/when_do_the_clocks_change_test.rb#L14
  # [^2]: https://github.com/alphagov/frontend/blob/d98da1aa0f62eb12b57af37f45bd9d728d1097ba/test/integration/bank_holidays_test.rb
  #
  Scenario: Check calendars pages
    Then I should be able to visit:
      | Path                       |
      | /when-do-the-clocks-change |
      | /bank-holidays             |


  # TODO: REMOVE this test as it does not meet the eligibility
  # criteria in docs/writing-tests.md.
  #
  # - Covers site-wide config: N (not applicable)
  # - Targets data transfer: N (already covered)
  # - Second critical check: N (arbitrary page)
  #
  # Data transfer with Content Store is implicitly covered by
  # "Check homepage content type and charset".
  #
  # Also tested in app [^1][^2].
  #
  # [^1]: https://github.com/alphagov/frontend/blob/d98da1aa0f62eb12b57af37f45bd9d728d1097ba/test/integration/icalendar_test.rb
  # [^2]: https://github.com/alphagov/frontend/blob/d98da1aa0f62eb12b57af37f45bd9d728d1097ba/test/integration/json_test.rb
  #
  Scenario: Check alternative formats are available
    Then I should be able to visit:
      | Path                                           |
      | /when-do-the-clocks-change/united-kingdom.json |
      | /when-do-the-clocks-change/united-kingdom.ics  |

  # TODO: REMOVE this test as it does not meet the eligibility
  # criteria in docs/writing-tests.md.
  #
  # - Covers site-wide config: N (not applicable)
  # - Targets data transfer: N (already covered)
  # - Second critical check: N (arbitrary page)
  #
  # Data transfer with Content Store is implicitly covered by
  # "Check homepage content type and charset".
  #
  # Also tested in app [^1].
  #
  # [^1]: https://github.com/alphagov/frontend/blob/d98da1aa0f62eb12b57af37f45bd9d728d1097ba/test/integration/json_test.rb
  #
  Scenario: Check bank holidays JSON format is consistent
    When I request "/bank-holidays.json"
    Then JSON is returned
