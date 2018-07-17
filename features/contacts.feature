Feature: Contacts

  Background:
    Given I am testing through the full stack
    And I force a varnish cache miss

  @normal
  Scenario: viewing contacts finder
    When I visit "/government/organisations/hm-revenue-customs/contact"
    Then I should see "Contact HM Revenue &amp; Customs"

  @normal
  Scenario: viewing a contact
    When I visit "/government/organisations/hm-revenue-customs/contact/child-benefit"
    Then I should see "Child Benefit"
