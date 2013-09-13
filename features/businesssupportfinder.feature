Feature: Business Support Finder

  @normal
  Scenario: check business support finder loads
    Given the "businesssupportfinder" application has booted
    And I am testing through the full stack
    And I force a varnish cache miss
    Then I should be able to visit:
      | Path                                                                                                                          |
      | /business-finance-support-finder                                                                                              |
      | /business-finance-support-finder/sectors                                                                                      |
      | /business-finance-support-finder/stage?sectors=education                                                                      |
      | /business-finance-support-finder/size?sectors=education&stage=start-up                                                        |
      | /business-finance-support-finder/types?sectors=education&stage=start-up&size=under-10                                         |
      | /business-finance-support-finder/location?sectors=education&stage=start-up&size=under-10&types=finance                        |
      | /business-finance-support-finder/support-options?location=wales&sectors=education&stage=start-up&size=under-10&types=finance  |

  @low
  Scenario: Quickly loading the business support finder home page
    Given the "businesssupportfinder" application has booted
    And I am benchmarking
    And I am testing through the full stack
    When I visit "/business-finance-support-finder"
    Then the elapsed time should be less than 1 seconds
