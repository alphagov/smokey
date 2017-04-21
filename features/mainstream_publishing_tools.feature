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

  @high
  Scenario: Can log in to local-links-manager
    When I go to the "local-links-manager" landing page
      And I try to login as a user
      And I go to the "local-links-manager" landing page
    Then I should see "Local Links Manager"
      And I should see "Sign out"
      And I should see "Councils"

  @high
  Scenario: Can log in to manuals-publisher
    When I go to the "manuals-publisher" landing page
      And I try to login as a user
      And I go to the "manuals-publisher" landing page
    Then I should see "Manuals Publisher"
      And I should see "Sign out"
      And I should see "Your manuals"
      And I should see "New manual"
