Feature: Contacts

  @normal
  Scenario: viewing contacts finder
    Given I am testing through the full stack
    And I force a varnish cache miss
    When I visit "/government/organisations/hm-revenue-customs/contact"
    Then I should see "HM Revenue &amp; Customs Contacts"

  @normal
  Scenario: viewing a contact
    Given I am testing through the full stack
    And I force a varnish cache miss
    When I visit "/government/organisations/hm-revenue-customs/contact/child-benefit"
    Then I should see "Child Benefit"
