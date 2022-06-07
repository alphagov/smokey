@app-licensing @replatforming
Feature: Licensing
  Tests for the Licensify app.

  Scenario: Check licensing app is present
    Given I force a varnish cache miss
    And I don't care about JavaScript errors
    Then I should be able to visit:
      | Path                                                              |
      | /apply-for-a-licence/test-licence/westminster/apply-1             |
      | /apply-for-a-licence/test-licence/westminster/apply-1/form        |
      | /apply-for-a-licence/forms/bury/test-licence/9999-7-1,0-1         |

  @notreplatforming
  Scenario: Check signing in to licensify-admin
    When I try to login as a user
    And I login to Licensify
    Then I should see "Sign Out"
