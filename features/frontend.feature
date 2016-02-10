Feature: Frontend

  Background:
    Given I am testing through the full stack
    And I force a varnish cache miss

  @normal
  Scenario: check robots.txt
    When I visit "/robots.txt"
    Then I should get a 200 status code
    Then I should see "User-agent:"

  @normal
  Scenario: check quick answers load
    When I visit "/vat-rates"
    Then I should see "VAT rates"

  @normal
  Scenario: check guides load
    When I visit "/getting-an-mot"
    Then I should see "Getting an MOT"

  @normal
  Scenario: check transactions load
    When I visit "/apply-renew-passport"
    Then I should see "UK passport"

  @normal
  Scenario: check benefit schemes load
    When I visit "/pension-credit"
    Then I should see "Pension Credit"

  @normal
  Scenario: check homepage content type & charset
    When I visit "/"
    Then I should get a Content-Type header of "text/html; charset=utf-8"

  @normal
  Scenario: check 404 page content type & charset
    When I visit a non-existent page
    Then I should get a Content-Type header of "text/html; charset=utf-8"

  @normal
  Scenario: check licences load
    When I visit "/busking-licence"
    Then I should see "Busking licence"
     And I should see an input field for entering my postcode
    When I try to post to "/busking-licence" with "postcode=E20+2ST"
    Then I should get a 200 status code
     And I should see "Busking licence"

  @normal
  Scenario: check local transactions load
    When I visit "/pay-council-tax"
    Then I should see "Pay your Council Tax"
    When I try to post to "/pay-council-tax" with "postcode=WC2B+6SE"
    Then I should see "London Borough of Camden"

  @normal
  Scenario: check find my nearest returns results
    When I try to post to "/ukonline-centre-internet-access-computer-training.json" with "postcode=WC2B+6NH"
    Then I should get a 200 status code
    And I should see "Holborn Library"

  @normal
  Scenario: check find my nearest (places) load
    When I visit "/ukonline-centre-internet-access-computer-training"
    Then I should get a 200 status code
    And I should see "UK online centres"

  @normal
  Scenario: check campaign pages load
    When I visit "/workplacepensions"
    Then I should get a 200 status code

  @normal
  Scenario: check browse page load, and links
    When I visit "/browse/driving"
    Then I should get a 200 status code
    And I should see "Teaching people to drive"
    When I click on the section "Teaching people to drive"
    Then I should get a 200 status code
    And I should see "Apply to become a driving instructor"
