Feature: Business Support Finder

  @normal
  Scenario: check business support finder loads
    Given the "businesssupportfinder" application has booted
    And I am testing through the full stack
    And I force a varnish cache miss
    Then I should be able to visit:
      | Path                                                                                                                        |
      | /business-finance-support-finder                                                                                            |
      | /business-finance-support-finder/sectors                                                                                    |
      | /business-finance-support-finder/stage?sectors=education                                                                    |
      | /business-finance-support-finder/structure?sectors=education&stage=pre-startup                                              |
      | /business-finance-support-finder/location?sectors=education&stage=start-up&structure=private-company                        |
      | /business-finance-support-finder/support-options?location=wales&sectors=education&stage=start-up&structure=private-company  |

  @low
  Scenario: Quickly loading the business support finder home page
    Given the "businesssupportfinder" application has booted
    And I am benchmarking
    And I am testing through the full stack
    When I visit "/business-finance-support-finder"
    Then the elapsed time should be less than 1 seconds
