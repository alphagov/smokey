@app-licensing
Feature: Licensing
  Scenario: Check licensing pages load
    Given I don't care about JavaScript errors
    Then I should be able to visit:
      | Path                                                              |
      | /apply-for-a-licence/test-licence/westminster/apply-1             |
      | /apply-for-a-licence/test-licence/westminster/apply-1/form        |
      | /apply-for-a-licence/forms/bury/test-licence/9999-7-1,0-1         |

  Scenario: Check log in to licensify-admin
    Given I don't care about JavaScript errors
    When I try to login as a user
    And I login to Licensify
    Then I should see "Sign Out"
