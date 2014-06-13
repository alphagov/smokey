Feature: Contacts

  @normal
  Scenario: check contacts app can be reached
    Given I am testing through the full stack
    And I force a varnish cache miss
    Then I should be able to visit:
      | Path                                      |
      | /contact/hm-revenue-customs               |
      | /contact/hm-revenue-customs/child-benefit |
