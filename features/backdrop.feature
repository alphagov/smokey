Feature: Backdrop

  @normal
  Scenario: Grouping queries are allowed on all buckets
    Given I am testing "backdrop"
      And I am testing through the full stack
     Then I should get a 200 response when I try to visit:
      | Path                                                 |
      | /performance/licensing/api/application?group_by=foo  |
      | /performance/licensing/api/journey?group_by=foo      |
      | /performance/government/api/annotations?group_by=foo |

  @normal
  Scenario: Raw queries are forbidden by default
    Given I am testing "backdrop"
      And I am testing through the full stack
     Then I should get a 400 response when I try to visit:
      | Path                                   |
      | /performance/licensing/api/application |

  @normal
  Scenario: Raw queries are allowed on some buckets
    Given I am testing "backdrop"
      And I am testing through the full stack
     Then I should get a 200 response when I try to visit:
      | Path                                    |
      | /performance/licensing/api/journey      |
      | /performance/government/api/annotations |
