Feature: Mirror

    @high
    Scenario Outline: Test mirror response profile
      Given there are 2 mirrors and 2 providers
      Then I should get a <Status> response from "<Page>" on the mirrors

      Examples:
          | Page                   | Status |
          | /                      | 200    |
          | /council-tax-reduction | 200    |
          | /jasdu3jjasd           | 503    |
          | /search                | 503    |
