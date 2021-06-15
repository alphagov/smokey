@app-publisher @replatforming
Feature: (Mainstream) Publisher

  @local-network
  Scenario: Healthcheck
    Given I am testing "publisher" internally
    When I request "/healthcheck/ready"
    Then JSON is returned
    And I should see ""status":"ok""

  @notstaging @notproduction
  Scenario: Can create a draft place
    Given I have the smokey run identifier
    When I try to login as a user
    And I go to the "publisher" landing page
    And I go to add an artefact
    And I create a draft place
    And I preview the draft place
    Then I should see that the content has been published

  @notstaging @notproduction
  Scenario: Can publish a draft place to live
    Given I have the smokey run identifier
    When I try to login as a user
    And I go to the "publisher" landing page
    And I search for the content in category "Drafts"
    And I go to the content from the search results
    And I request 2nd pair of eyes
    And I skip the review
    And I publish the draft
    And I view the published content on live
    Then I should see that the content has been published

  @notstaging @notproduction
  Scenario: Can unpublish a live place
    Given I have the smokey run identifier
    When I try to login as a user
    And I go to the "publisher" landing page
    And I search for the content in category "Published"
    And I go to the content from the search results
    And I go to the "Unpublish" section
    And I unpublish the edition
    Then I should see that the content has been unpublished
