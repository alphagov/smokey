@replatforming @app-contacts
Feature: Contacts

  Background:
    Given I am testing through the full stack
    And I force a varnish cache miss

  # TODO: REMOVE this test as it is a duplicate.
  #
  # Duplicate of "Check contacts finder loads correctly".
  #
  Scenario: Check the contacts finder
    When I visit "/government/organisations/hm-revenue-customs/contact"
    Then I should see "Contact HM Revenue &amp; Customs"

  # TODO: REMOVE this test as it does not meet the eligibility
  # criteria in docs/writing-tests.md.
  #
  # - Covers site-wide config: N (not applicable)
  # - Targets data transfer: N (already covered)
  # - Second critical check: N (not a critical feature)
  #
  # This page is rendered by Government Frontend. Data transfer
  # for this app with Content Store is already covered by
  # "Ensure static content is rendered".
  #
  # Also tested in app [^1].
  #
  # [^1]: https://github.com/alphagov/government-frontend/blob/fe38c9405ade2f53abc076da70a50eccd7cc08fe/test/integration/contact_test.rb
  #
  Scenario: Check viewing a contact
    When I visit "/government/organisations/hm-revenue-customs/contact/child-benefit"
    Then I should see "Child Benefit"
