Feature: Licensing

  @normal
  Scenario: check licensing app is present
    Given I am testing "licensing"
      And I am testing through the full stack
      And I force a varnish cache miss
    Then I should be able to visit:
      | Path                                                              |
      | /apply-for-a-licence/test-licence/westminster/apply-1             |
      | /apply-for-a-licence/test-licence/westminster/apply-1/form        |
      | /apply-for-a-licence/forms/bury/test-licence/9999-7-1,0-1         |

  @normal
  Scenario: Loading a pdf in a reasonable amount of time
    Given I am testing "licensing"
      And I am benchmarking
      And I am testing through the full stack
      And I force a varnish cache miss
    When I visit "/apply-for-a-licence/forms/bury/test-licence/9999-7-1,0-1"
    Then the elapsed time should be less than 10 seconds

  @normal
  Scenario: Signing in to licensify-admin
     When I try to login as a user
      And I login to Licensify
     Then I should see "There are no applications available for processing"
