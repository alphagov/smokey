@app-licencefinder @replatforming
Feature: Licence Finder

  Background:
    Given I am testing through the full stack
    And I force a varnish cache miss

  # TODO: REMOVE the following examples (rendered by frontend).
  #
  # - /licence-finder (transaction, covered by "Check transactions load")
  #
  # TODO: REMOVE this test as it does not meet the eligibility
  # criteria in docs/writing-tests.md.
  #
  # - Covers site-wide config: N (not applicable)
  # - Targets data transfer: N (already covered)
  # - Second critical check: N (arbitrary pages)
  #
  # Data transfer with Content Store and Search API is already
  # covered by "Check licence finder returns licences".
  #
  # Also tested in app, as follows.
  #
  # - /licence-finder/sectors (sectors_page_spec.rb)
  # - /licence-finder/sectors?sectors=&q=pub (sectors_page_spec.rb)
  # - /licence-finder/activities?sectors=59 (activities_page_spec.rb)
  # - /licence-finder/location?sectors=59&activities=149 (business_location_page_spec.rb)
  # - /licence-finder/licences?activities=149&location=wales&sectors=59 (licences_page_spec.rb)
  #
  Scenario: Check licence finder loads
    Then I should be able to visit:
      | Path                                                              |
      | /licence-finder                                                   |
      | /licence-finder/sectors                                           |
      | /licence-finder/sectors?sectors=&q=pub                            |
      | /licence-finder/activities?sectors=59                             |
      | /licence-finder/location?sectors=59&activities=149                |
      | /licence-finder/licences?activities=149&location=wales&sectors=59 |

  Scenario: Check licence finder returns licences
    When I visit "/licence-finder/licences?activities=149&location=wales&sectors=59"
    Then I should see "A premises licence is for carrying out 'licensable activities' at a particular venue"
