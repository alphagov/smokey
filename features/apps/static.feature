Feature: Static

  # TODO: EXPORT this test as it does not meet the eligibility
  # criteria in docs/writing-tests.md.
  #
  # - Covers site-wide config: N (not applicable)
  # - Targets data transfer: N (not applicable)
  # - Second critical check: N (not tested in app)
  #
  # Partially tested in Slimmer [^1] but should be tested in
  # Static [^2], although this test could still add value as
  # a second critical check these two codebases can integrate.
  #
  # [^1]: https://github.com/alphagov/slimmer/blob/82144be372aa4afc1f8ff30917c96c2ee3a47ed8/test/processors/feedback_url_swapper_test.rb
  # [^2]: https://github.com/alphagov/static/blob/9f835b87a3aa6ed867b98b2f4534dd64c9510626/app/views/root/_gem_base.html.erb#L43
  #
  Scenario: Check the feedback component loads
    When I visit "/help"
    And I click to report a problem with the page
    Then I see the report a problem form
    When I close the open feedback form
    And I click to say the page is not useful
    Then I see the email survey signup form
    When I close the open feedback form
    And I click to say the page is useful
    Then I see the feedback confirmation message
