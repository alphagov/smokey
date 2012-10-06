Feature: Frontend

  Background:
    Given the "frontend" application has booted
    And I am testing through the full stack
    And I force a varnish cache miss

  Scenario: check quick answers load
    When I visit "/vat-rates"
    Then I should see "VAT rates"

  Scenario: check guides load
    When I visit "/getting-an-mot/overview"
    Then I should see "Getting an MOT"

  Scenario: check transactions load
    When I visit "/apply-renew-passport"
    Then I should see "UK passport"

  Scenario: check benefit schemes load
    When I visit "/pension-credit"
    Then I should see "Pension Credit"

  Scenario: check licences load
    When I visit "/busking-licence"
    Then I should see "Busking licence"

  Scenario: check local transactions load
    When I visit "/pay-council-tax"
    Then I should see "Pay your Council Tax"

  @normal
  Scenario: check locator.json works
    When I try to post to "/locator.json" with "postcode=WC2B 6NH"
    Then I should get a 200 status code
    And I should see "Camden, London"
    And I should see "00AG"

  @normal
  Scenario: check find my nearest returns results
    When I try to post to "/uk-online-centre-internet-access-computer-training.json" with "lat=51.51502281807959&lon=-0.12151737435844158"
    Then I should get a 200 status code
    And I should see "Holborn Library"
