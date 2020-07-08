Feature: Licence Finder

  Background:
    Given I am testing through the full stack
    And I force a varnish cache miss

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

  Scenario: Check licence postcode lookup
    When I visit "/temporary-events-notice"
    Then I should see "Temporary Events Notice"
     And I should see an input field for postcode
    When I try to post to "/temporary-events-notice" with "postcode=SW1A+2AA"
    Then I should see "Westminster City Council"
