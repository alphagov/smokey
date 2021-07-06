Feature: Feedback

  Background:
    Given I am testing through the full stack
    And I force a varnish cache miss

  @app-feedback @local-network
  Scenario: Healthcheck
    Given I am testing "feedback" internally
    When I request "/healthcheck/ready"
    Then JSON is returned
    And I should see ""status":"ok""

  Scenario: Check the "Contact GOV.UK" page loads correctly
    When I visit "/contact/govuk"
    Then I should see "Contact GOV.UK"

  Scenario: Check malicious code does not execute
    When I visit "/contact/govuk"
    And I input malicious code in the email field
    Then I see the code returned in the page

  Scenario: Check the FoI page loads correctly
    When I visit "/contact/foi"
    Then I should see "How to make a freedom of information (FOI) request"

  Scenario: Check "is this page useful?" email survey
    When I visit "/"
    And I click to say the page is not useful
    And I submit the email survey signup form
    Then I see the feedback confirmation message
    And a request is sent to the feedback app

  Scenario: Check feedback component behaviour
    When I visit "<url>"
    And I confirm it is rendered by "<application>"
    And I click to report a problem with the page
    Then I see the report a problem form
    When I close the open feedback form
    And I click to say the page is not useful
    Then I see the email survey signup form
    When I close the open feedback form
    And I click to say the page is useful
    Then I see the feedback confirmation message

    @app-collections
    Examples:
      | url                       | application |
      | /government/organisations | collections |

    @app-email-frontend
    Examples:
      | url                        | application          |
      | /email/manage/authenticate | email-alert-frontend |

    @app-feedback
    Examples:
      | url            | application |
      | /contact/govuk | feedback    |

    @app-finder-frontend
    Examples:
      | url                             | application     |
      | /search/news-and-communications | finder-frontend |

    @app-frontend
    Examples:
      | url | application |
      | /   | frontend    |

    @app-government-frontend
    Examples:
      | url               | application         |
      | /help/about-govuk | government-frontend |

    @app-info-frontend
    Examples:
      | url             | application   |
      | /info/vat-rates | info-frontend |

    @app-licencefinder
    Examples:
      | url                     | application   |
      | /licence-finder/sectors | licencefinder |

    @app-manuals-frontend
    Examples:
      | url                      | application      |
      | /guidance/content-design | manuals-frontend |

    @app-service-manual-frontend
    Examples:
      | url             | application             |
      | /service-manual | service-manual-frontend |

    @app-smartanswers
    Examples:
      | url              | application  |
      | /marriage-abroad | smartanswers |

    @app-whitehall
    Examples:
      | url    | application |
      | /world | whitehall   |
