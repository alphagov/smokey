@notproduction
Feature: FCO services

  @normal
  Scenario: Accessing the Pay Legalisation Post start page
    Given I am testing the "pay-legalisation-post" FCO service
    And I force a varnish cache miss
    When I visit "/start"
    Then I should get a 200 status code
    And I should see "How many documents do you want legalised?"

  @normal
  Scenario: Accessing the Pay Legalisation Drop-off start page
    Given I am testing the "pay-legalisation-drop-off" FCO service
    And I force a varnish cache miss
    When I visit "/start"
    Then I should get a 200 status code
    And I should see "How many documents do you want legalised?"

  @normal
  Scenario: Accessing the Deposit Foreign Marriage Certificate start page
    Given I am testing the "deposit-foreign-marriage" FCO service
    And I force a varnish cache miss
    When I visit "/start"
    Then I should get a 200 status code
    And I should see "General Register Office"

  @normal
  Scenario: Accessing the Pay Foreign Marriage Certificates start page
    Given I am testing the "pay-foreign-marriage-certificates" FCO service
    And I force a varnish cache miss
    When I visit "/start"
    Then I should get a 200 status code
    And I should see "Which type of certificate do you need?"

  @normal
  Scenario: Accessing the Pay Register Death Abroad start page
    Given I am testing the "pay-register-death-abroad" FCO service
    And I force a varnish cache miss
    When I visit "/start"
    Then I should get a 200 status code
    And I should see "How many death certificates do you need?"

  @normal
  Scenario: Accessing the Pay Register Birth Abroad start page
    Given I am testing the "pay-register-birth-abroad" FCO service
    And I force a varnish cache miss
    When I visit "/start"
    Then I should get a 200 status code
    And I should see "How many birth certificates do you need?"

  @normal
  Scenario: Accessing the EPDQ template
    Given I am testing the "pay-legalisation-post" FCO service
    And I am not an authenticated user
    And I force a varnish cache miss
    When I visit "/assets/barclays_epdq.html"
    Then I should get a 200 status code
    And I should see "$$$PAYMENT ZONE$$$"
