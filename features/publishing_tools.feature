Feature: Publishing Tools

  @high
  Scenario: Can log in to collections-publisher
    When I go to the "collections-publisher" landing page
    And I try to login as a user
    And I go to the "collections-publisher" landing page
    Then I should see "Collections Publisher"
    And I should see "Sign out"
    And I should see "Mainstream browse pages"
    And I should see "Add a mainstream browse page"

  @high
  Scenario: Can log in to contacts-admin
    When I go to the "contacts-admin" landing page
    And I try to login as a user
    And I go to the "contacts-admin" landing page
    Then I should see "GOV.UK Contacts"
    And I should see "Sign out"
    And I should see "Contacts"
    And I should see "Add contact"

  @high
  Scenario: Can log in to content-tagger
    When I go to the "content-tagger" landing page
    And I try to login as a user
    And I go to the "content-tagger" landing page
    Then I should see "Content Tagger"
    And I should see "Sign out"
    And I should see "Taxons"

  @high
  Scenario: Can log in to imminence
    When I go to the "imminence" landing page
    And I try to login as a user
    And I go to the "imminence" landing page
    Then I should see "GOV.UK Imminence"
    And I should see "Sign out"
    And I should see "All services"

  @high
  Scenario: Can log in to local-links-manager
    When I go to the "local-links-manager" landing page
    And I try to login as a user
    And I go to the "local-links-manager" landing page
    Then I should see "Local Links Manager"
    And I should see "Sign out"
    And I should see "Council"

  @high
  Scenario: Can log in to manuals-publisher
    When I go to the "manuals-publisher" landing page
    And I try to login as a user
    And I go to the "manuals-publisher" landing page
    Then I should see "Manuals Publisher"
    And I should see "Sign out"
    And I should see "Your manuals"
    And I should see "New manual"

  @high
  Scenario: Can log in to maslow
    When I go to the "maslow" landing page
    And I try to login as a user
    And I go to the "maslow" landing page
    Then I should see "GOV.UK Maslow"
    And I should see "Sign out"
    And I should see "All needs"

  @high
  Scenario: Can log in to policy-publisher
    When I go to the "policy-publisher" landing page
    And I try to login as a user
    And I go to the "policy-publisher" landing page
    Then I should see "GOV.UK Policy Publisher"
    And I should see "Sign out"
    And I should see "Policies"
    And I should see "New policy"

  @high
  Scenario: Can log in to publisher
    When I go to the "publisher" landing page
    And I try to login as a user
    And I go to the "publisher" landing page
    Then I should see "GOV.UK Publisher"
    And I should see "Sign out"
    And I should see Publisher's publication index

  @high
  Scenario: Can log in to service-manual-publisher
    When I go to the "service-manual-publisher" landing page
    And I try to login as a user
    And I go to the "service-manual-publisher" landing page
    Then I should see "GOV.UK Service Manual Publisher"
    And I should see "Sign out"
    And I should see "Create a Guide"

  @high
  Scenario: Can log in to short-url-manager
    When I go to the "short-url-manager" landing page
    And I try to login as a user
    And I go to the "short-url-manager" landing page
    Then I should see "Short URL manager"
    And I should see "Sign out"
    And I should see "Dashboard"
    And I should see "Request a new URL redirect or short URL"

  @high
  Scenario: Can log in to specialist-publisher
    When I go to the "specialist-publisher" landing page
    And I try to login as a user
    And I go to the "specialist-publisher" landing page
    Then I should see "GOV.UK Specialist Publisher"
    And I should see "Sign out"
    And I should see "CMA Cases"
    And I should see "Add another CMA Case"

  @high
  Scenario: Can log in to travel-advice-publisher
    When I go to the "travel-advice-publisher" landing page
    And I try to login as a user
    And I go to the "travel-advice-publisher" landing page
    Then I should see "GOV.UK Travel Advice Publisher"
    And I should see "Sign out"
    And I should see "All countries"

  @high
  Scenario: Can log in to whitehall
    When I go to the "whitehall-admin" landing page
    And I try to login as a user
    And I go to the "whitehall-admin" landing page
    Then I should see "GOV.UK Whitehall"
    And I should see "Logout"
    And I should see "Dashboard"
    And I should see "My draft documents"
