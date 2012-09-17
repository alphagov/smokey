Feature: Frontend

  Scenario: check quick answers load
    Given the "frontend" application has booted
    And I am testing through the full stack
    And I force a varnish cache miss
    When I visit "/vat-rates"
    Then I should see "VAT rates"

  Scenario: check guides load
    Given the "frontend" application has booted
    And I am testing through the full stack
    And I force a varnish cache miss
    When I visit "/getting-an-mot/overview"
    Then I should see "Getting an MOT"

  Scenario: check transactions load
    Given the "frontend" application has booted
    And I am testing through the full stack
    And I force a varnish cache miss
    When I visit "/apply-renew-passport"
    Then I should see "UK passport"

  Scenario: check benefit schemes load
    Given the "frontend" application has booted
    And I am testing through the full stack
    And I force a varnish cache miss
    When I visit "/pension-credit"
    Then I should see "Pension Credit"

  Scenario: check licences load
    Given the "frontend" application has booted
    And I am testing through the full stack
    And I force a varnish cache miss
    When I visit "/busking-licence"
    Then I should see "Busking licence"

  Scenario: check local transactions load
    Given the "frontend" application has booted
    And I am testing through the full stack
    And I force a varnish cache miss
    When I visit "/pay-council-tax"
    Then I should see "Pay your Council Tax"
