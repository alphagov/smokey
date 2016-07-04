Feature: Mainstream Publishing Tools
  @high
  Scenario: Can log in to publisher
    When I go to the "publisher" landing page
      And I try to login as a user
      And I go to the "publisher" landing page
    Then I should see "GOV.UK Publisher"
      And I should see "Sign out"
      And I should see Publisher's publication index

  @high
  Scenario: Can log in to panopticon
    When I go to the "panopticon" landing page
      And I try to login as a user
      And I go to the "panopticon" landing page
    Then I should see "GOV.UK Panopticon"
      And I should see "Sign out"
      And I should see "artefacts"

  @high
  Scenario: Can log in to imminence
    When I go to the "imminence" landing page
      And I try to login as a user
      And I go to the "imminence" landing page
    Then I should see "GOV.UK Imminence"
      And I should see "Sign out"
      And I should see "All services"

  @high
  Scenario: Can log in to travel-advice-publisher
    When I go to the "travel-advice-publisher" landing page
    And I try to login as a user
    And I go to the "travel-advice-publisher" landing page
    Then I should see "GOV.UK Travel Advice Publisher"
    And I should see "Sign out"
    And I should see "All countries"
