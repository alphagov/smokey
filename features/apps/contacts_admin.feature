@app-contacts-admin
Feature: Contacts Admin
  @app-publishing-api
  Scenario: Can log in to contacts-admin
    When I go to the "contacts-admin" landing page
    And I try to login as a user
    And I go to the "contacts-admin" landing page
    Then I should see "Contacts"
    And I should see "Add contact"
