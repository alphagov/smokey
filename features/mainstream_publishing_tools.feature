Feature: Mainstream Publishing Tools
  @high
  Scenario: Can log in to publisher
    Given the "signon" application has booted
      And the "publisher" application has booted
    When I go to the "publisher" landing page
      And I try to login as a user
      And I go to the "publisher" landing page
    Then I should see "GOV.UK Publisher"
      And I should see "Signed in"
      And I should see "“Lined up” publications"

  @high
  Scenario: Can log in to panopticon
    Given the "signon" application has booted
      And the "panopticon" application has booted
    When I go to the "panopticon" landing page
      And I try to login as a user
      And I go to the "panopticon" landing page
    Then I should see "GOV.UK Panopticon"
      And I should see "Signed in"
      And I should see "Artefacts"

  @high
  Scenario: Can log in to imminence
    Given the "signon" application has booted
      And the "imminence" application has booted
    When I go to the "imminence" landing page
      And I try to login as a user
      And I go to the "imminence" landing page
    Then I should see "GOV.UK Imminence
      And I should see "Signed in"
      And I should see "Services"
