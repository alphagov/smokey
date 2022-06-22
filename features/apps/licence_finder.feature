@app-licencefinder @replatforming
Feature: Licence Finder

  Scenario: Check licence finder returns licences
    When I visit "/licence-finder/licences?activities=149&location=wales&sectors=59"
    Then I should see "A premises licence is for carrying out 'licensable activities' at a particular venue"

  # TODO: EXPORT this test as it does not meet the eligibility
  # criteria in docs/writing-tests.md.
  #
  # - Covers site-wide config: N (not applicable)
  # - Targets data transfer: N (not applicable)
  # - Second critical check: N (not tested in app)
  #
  # Should be tested in Licence Finder, if at all, when the app
  # takes over from Static and renders its own layout [^1].
  #
  # [^1]: https://github.com/alphagov/smokey/pull/976#discussion_r903528402
  #
  Scenario: Check the feedback component loads
    When I visit "/licence-finder/sectors"
    And I confirm it is rendered by "licencefinder"
    And I can operate the feedback component
