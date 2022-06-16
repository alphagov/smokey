@app-licencefinder @replatforming
Feature: Licence Finder

  Scenario: Check licence finder returns licences
    When I visit "/licence-finder/licences?activities=149&location=wales&sectors=59"
    Then I should see "A premises licence is for carrying out 'licensable activities' at a particular venue"

  Scenario: Check the feedback component loads
    When I visit "/licence-finder/sectors"
    And I confirm it is rendered by "licencefinder"
    And I click to report a problem with the page
    Then I see the report a problem form
    When I close the open feedback form
    And I click to say the page is not useful
    Then I see the email survey signup form
    When I close the open feedback form
    And I click to say the page is useful
    Then I see the feedback confirmation message
