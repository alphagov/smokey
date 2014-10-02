Feature: Backdrop

  @normal
  Scenario: Grouping queries are allowed on all buckets
    Given I am testing "backdrop"
      And I am testing through the full stack
    Then I should get a 200 response when I try to visit:
      | Path                                                 |
      | /performance/licensing/api/application?group_by=foo  |
      | /performance/licensing/api/journey?group_by=foo      |
