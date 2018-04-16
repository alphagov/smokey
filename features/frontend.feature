Feature: Frontend

  Background:
    Given I am testing through the full stack
    And I force a varnish cache miss

  @normal
  Scenario: check robots.txt
    When I request "/robots.txt"
    Then I should get a 200 status code
    Then I should see "User-agent:"

  @normal
  Scenario: check quick answers load
    When I visit "/vat-rates"
    Then I should see "VAT rates"
     And The frontend app is "government-frontend"

  @normal
  Scenario: check guides load
    When I visit "/getting-an-mot"
    Then I should see "Getting an MOT"
     And The frontend app is "government-frontend"

  @normal
  Scenario: check transactions load
    When I visit "/apply-renew-passport"
    Then I should see "UK passport"
     And The frontend app is "frontend"

  @normal
  Scenario: check benefit schemes load
    When I visit "/pension-credit"
    Then I should see "Pension Credit"
     And The frontend app is "government-frontend"

  @normal
  Scenario: check homepage content type & charset
    When I request "/"
    Then I should get a "Content-Type" header of "text/html; charset=utf-8"
     And The frontend app is "frontend"

  @normal
  Scenario: check 404 page content type & charset
    When I visit a non-existent page
    Then I should get a "Content-Type" header of "text/html; charset=utf-8"

  @normal
  Scenario: check licences load
    When I visit "/busking-licence"
    Then I should see "Busking licence"
     And I should see an input field for postcode
     And The frontend app is "frontend"
    When I try to post to "/busking-licence" with "postcode=E20+2ST"
    Then I should get a 200 status code
     And I should see "Busking licence"
     And The frontend app is "frontend"

  @normal
  Scenario: check local transactions load
    When I visit "/pay-council-tax"
    Then I should see "Pay your Council Tax"
     And The frontend app is "frontend"
    When I try to post to "/pay-council-tax" with "postcode=WC2B+6SE"
    Then I should see "Camden"
     And The frontend app is "frontend"

  @normal
  Scenario: check find my nearest returns results
    When I visit "/ukonline-centre-internet-access-computer-training"
    Then I should see "UK online centres"
     And The frontend app is "frontend"
    When I try to post to "/ukonline-centre-internet-access-computer-training" with "postcode=WC2B+6NH"
    Then I should get a 200 status code
     And I should see "Holborn Library"
     And The frontend app is "frontend"

  @normal
  Scenario: check campaign pages load
    When I visit "/workplacepensions"
    Then I should be at a location path of "/workplace-pensions"
     And The frontend app is "government-frontend"

  @normal
  Scenario: check browse page load, and links
    When I visit "/browse/driving"
    Then I should get a 200 status code
     And I should see "Teaching people to drive"
     And The frontend app is "collections"
    When I click on the section "Teaching people to drive"
    Then I should get a 200 status code
     And I should see "Apply to become a driving instructor"
     And The frontend app is "collections"
