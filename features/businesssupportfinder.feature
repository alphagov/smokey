Feature: Business Support Finder

  @normal
  Scenario: check business support finder loads
    Given the "businesssupportfinder" application has booted
    And I am testing through the full stack
    And I force a varnish cache miss
    Then I should be able to visit:
      | Path                                                                                                                          |
      | /business-finance-support-finder                                                                                              |
      | /business-finance-support-finder/search                                                                                       |
      | /business-finance-support-finder/search?support_types%5B%5D=finance&support_types%5B%5D=equity&support_types%5B%5D=grant&support_types%5B%5D=loan&support_types%5B%5D=expertise-and-advice&support_types%5B%5D=recognition-award&support_types_submitted=true&location=england&size=between-501-and-1000&sector=travel-and-leisure&stage=grow-and-sustain&commit=#filtered-results                          |

  @low
  Scenario: Quickly loading the business support finder home page
    Given the "businesssupportfinder" application has booted
    And I am benchmarking
    And I am testing through the full stack
    When I visit "/business-finance-support-finder"
    Then the elapsed time should be less than 1 seconds
