Feature: Licensing
  Tests for the Licensify app.

  @notintegration @nottraining
  Scenario: Check licensing app is present
    Given I am testing "licensing" internally
      And I am testing through the full stack
      And I force a varnish cache miss
    Then I should be able to visit:
      | Path                                                              |
      | /apply-for-a-licence/test-licence/westminster/apply-1             |
      | /apply-for-a-licence/test-licence/westminster/apply-1/form        |
      | /apply-for-a-licence/forms/bury/test-licence/9999-7-1,0-1         |

  @notintegration @nottraining
  Scenario: Check signing in to licensify-admin
     When I try to login as a user
      And I login to Licensify
     Then I should see "Sign Out"
