Feature: Contacts

  @draft
  @normal
  Scenario: check contacts app can be reached
    Given I am testing through the full stack
    And I force a varnish cache miss
    Then I should be able to visit:
      | Path                                                               |
      | /government/organisations/hm-revenue-customs/contact               |
      | /government/organisations/hm-revenue-customs/contact/child-benefit |
