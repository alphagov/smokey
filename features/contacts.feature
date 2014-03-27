Feature: Contacts

  @normal
  Scenario: check contacts app can be reached
    Given I am testing through the full stack
    And the "contacts" application has booted
    And I force a varnish cache miss
    Then I should be able to visit:
      | Path                        |
      | /contact/hm-revenue-customs |
