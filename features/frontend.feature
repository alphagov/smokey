@aws
Feature: Frontend

  Background:
    Given I am testing through the full stack
    And I force a varnish cache miss

  @normal
  Scenario: Check robots.txt
    When I request "/robots.txt"
    Then I should see "User-agent:"

  @normal
  Scenario: Check transactions load
    When I visit "/apply-renew-passport"
    Then I should see "UK passport"

  @normal
  Scenario: Check help page loads correctly
    When I visit "/help"
    Then I should see "Help using GOV.UK"

  @normal
  Scenario: Check homepage content type and charset
    When I request "/"
    Then I should get a "Content-Type" header of "text/html; charset=utf-8"

  @normal
  Scenario: Check 404 page content type and charset
    When I visit a non-existent page
    Then I should get a "Content-Type" header of "text/html; charset=utf-8"

  @normal
  Scenario: Check licences load
    When I visit "/busking-licence"
    Then I should see "Busking licence"
     And I should see an input field for postcode
    When I try to post to "/busking-licence" with "postcode=E20+2ST"
    Then I should see "Busking licence"

  @normal
  Scenario: Check local transactions load
    When I visit "/pay-council-tax"
    Then I should see "Pay your Council Tax"
    When I try to post to "/pay-council-tax" with "postcode=WC2B+6SE"
    Then I should see "Camden"

  @normal
  Scenario: Check "find my nearest" returns results
    When I visit "/ukonline-centre-internet-access-computer-training"
    And I should see "Online Centres Network"
    When I try to post to "/ukonline-centre-internet-access-computer-training" with "postcode=WC2B+6NH"
    Then I should see "Holborn Library"

  @normal
  Scenario: Check redirects work
    When I visit "/workplacepensions"
    Then I should be at a location path of "/workplace-pensions"
