@aws
Feature: Contacts

  Background:
    Given I am testing through the full stack
    And I force a varnish cache miss

  Scenario: Check the contacts finder
    When I visit "/government/organisations/hm-revenue-customs/contact"
    Then I should see "Contact HM Revenue &amp; Customs"

  Scenario: Check viewing a contact
    When I visit "/government/organisations/hm-revenue-customs/contact/child-benefit"
    Then I should see "Child Benefit"
