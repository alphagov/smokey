Feature: Frontend

  Background:
    Given the "frontend" application has booted
    And I am testing through the full stack
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
  Scenario: check licences load
    When I visit "/busking-licence"
    Then I should see "Busking licence"

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
  Scenario: check special tax disc start page
    When I visit "/tax-disc"
    Then I should get a 200 status code
    And I should see "Renew a tax disc"
    And I should see "Apply now"
    And I should see "Apply using the new service"
    And I should see "https://www.taxdisc.service.gov.uk"

  @normal
  Scenario: check special view driving licence start page
    When I visit "/view-driving-licence"
    Then I should get a 200 status code
    And I should see "View your driving licence information"
    And I should see "View the new service"
    And I should see "View using the original service"
    And I should see "View now"
    And I should see "https://www.viewdrivingrecord.service.gov.uk"

  @normal
  Scenario: check special check vehicle tax status start page
    When I visit "/check-vehicle-tax"
    Then I should get a 200 status code
    And I should see "Check if a vehicle is taxed"
    And I should see "Check using the new service"
    And I should see "Check using the original service"
    And I should see "Check now"
    And I should see "https://www.vehicleenquiry.service.gov.uk"

  @normal
  Scenario: check browse page load, and links
    When I visit "/browse/driving"
    Then I should get a 200 status code
    And I should see "Book your driving test or get a tax disc online"
    And I should see "Teaching people to drive"
    When I click "Teaching people to drive"
    Then I should get a 200 status code
    And I should see "Apply to become a driving instructor"
