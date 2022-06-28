Feature: Static

  # TODO: EXPORT this test as it does not meet the eligibility
  # criteria in docs/writing-tests.md.
  #
  # - Covers site-wide config: N (not applicable)
  # - Targets data transfer: N (not applicable)
  # - Second critical check: N (not tested in app)
  #
  # Should be tested in Static [^1].
  #
  # [^1]: https://github.com/alphagov/static/blob/9f835b87a3aa6ed867b98b2f4534dd64c9510626/app/views/root/_gem_base.html.erb#L43
  #
  Scenario: Check the crown logo links to GOV.UK homepage
    When I visit "/"
    Then the logo should link to the homepage

  # TODO: EXPORT this test as it does not meet the eligibility
  # criteria in docs/writing-tests.md.
  #
  # - Covers site-wide config: N (not applicable)
  # - Targets data transfer: N (not applicable)
  # - Second critical check: N (not tested in app)
  #
  # Should be tested in Static [^1].
  #
  # [^1]: https://github.com/alphagov/static/blob/9f835b87a3aa6ed867b98b2f4534dd64c9510626/app/views/root/_gem_base.html.erb#L43
  #
  Scenario: Check the feedback component loads
    When I visit "/help"
    And I confirm it is rendered by "frontend"
    And I can operate the feedback component
