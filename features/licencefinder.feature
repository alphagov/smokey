Feature: Licence Finder

  Scenario: check licence finder loads
    Given the "licencefinder" application has booted
    And I am testing through the full stack
    And I force a varnish cache miss
    Then I should be able to visit:
      | Path                                                              |
      | /licence-finder                                                   |
      | /licence-finder/sectors                                           |
      | /licence-finder/sectors?sectors=&q=pub                            |
      | /licence-finder/activities?sectors=59                             |
      | /licence-finder/location?sectors=59&activities=149                |
      | /licence-finder/licences?activities=149&location=wales&sectors=59 |
  
  Scenario: Quickly loading the licence finder home page
    Given the "licencefinder" application has booted
    And I am benchmarking
    And I am testing through the full stack
    When I visit "/licence-finder"
    Then the elapsed time should be less than 1 seconds
