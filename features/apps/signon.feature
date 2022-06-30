@app-signon @replatforming
Feature: Signon
  Scenario: Check log in to signon
    When I try to login as a user
    Then I should see "Your applications"
