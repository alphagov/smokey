Feature: Limelight
  
  @normal
  Scenario: Limelight application is up
      Given I am testing "limelight"
        And I am testing through the full stack
        And I force a varnish cache miss
       Then I should be able to visit:
        | Path                                        |
        | /performance/licensing/                     |
        | /performance/licensing/licences             |
        | /performance/licensing/licences/childminder |
        | /performance/licensing/authorities          |
        | /performance/licensing/authorities/surrey   |
