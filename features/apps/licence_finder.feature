@app-licencefinder @replatforming
Feature: Licence Finder

  Scenario: Check licence finder returns licences
    When I visit "/licence-finder/licences?activities=149&location=wales&sectors=59"
    Then I should see "A premises licence is for carrying out 'licensable activities' at a particular venue"
