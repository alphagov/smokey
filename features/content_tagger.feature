@app-content-tagger
Feature: Content Tagger
  @app-publishing-api
  Scenario: Can log in to content-tagger
    When I go to the "content-tagger" landing page
    And I try to login as a user
    And I go to the "content-tagger" landing page
    Then I should see "Content Tagger"
    And I should see "Sign out"
    And I should see "Taxons"
