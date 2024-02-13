@app-publisher
Feature: Publisher
  @app-publishing-api
  Scenario: Can log in to publisher
    When I go to the "publisher" landing page
    And I try to login as a user
    And I go to the "publisher" landing page
    Then I should see "Publisher"
    And I should see Publisher's publication index

  @notproduction
  Scenario: Can add and delete an artefact in publisher
    When I go to the "publisher" landing page
    And I try to login as a user
    And I go to the "publisher" landing page
    And I add an artefact
    And I delete the artefact
    Then I should see that the edition has been deleted
