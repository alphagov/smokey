Feature: Get Involved Page
    Tests data loading and display for the Get Involved page.

    Background:
        Given I am testing through the full stack

    Scenario: Ensure the Get Involved page loads
        When I request "/government/get-involved"
        Then I should get a 200 status code

    Scenario: Ensure static content is rendered
        When I visit "/government/get-involved"
        Then I should see "Get involved"
        And I should see "Find out how you can engage with government directly, and take part locally, nationally or internationally."

    Scenario Outline: Ensure internal static links are correct
        When I visit "/government/get-involved"
        And I click on the link "<Link>"
        Then I should be at a location path of "<InternalPath>"

        Examples:
            | Link                                        | InternalPath                 |
            | See all government departments              | /government/organisations    |
            | Take part in your local Neighbourhood Watch | /do-something-your-community |

    Scenario Outline: Ensure search links are correct
        When I visit "/government/get-involved"
        Then I should see the search link "<SearchLinkText>"
        And it should link to "<SearchPage>"

        Examples:
            | SearchLinkText           | SearchPage                                                                                                                                          |
            | Search all consultations | /search/policy-papers-and-consultations?content_store_document_type%5B%5D=open_consultations&content_store_document_type%5B%5D=closed_consultations |
            | Open consultations       | /search/policy-papers-and-consultations?content_store_document_type=open_consultations                                                              |
            | Closed consultations     | /search/policy-papers-and-consultations?content_store_document_type=closed_consultations                                                            |

    Scenario: Ensure Next Closing box is populated
        When I visit "/government/get-involved"
        Then I should see the next closing box
        And it should be populated
        When I click the next closing response link
        Then I should see the next closing consultation

    Scenario: Ensure we can see three consultations that were recently opened
        When I visit "/government/get-involved"
        Then I should see "Recently opened"
        And it should be populated with three open consultations

    Scenario: Ensure we can see three recent consultation outcomes
        When I visit "/government/get-involved"
        Then I should see "Recent outcomes"
        And it should be populated with three closed consultations

    Scenario Outline: Ensure the Take Part pages are populated
        When I visit "/government/get-involved"
        Then I should see "Take part"
        And I should see "<Title>"
        When I click on the link "<Title>"
        And I should be at a location path of "<Path>"

        Examples:
            | Title                                                         | Path                                                                                                      |
            | Volunteer                                                     | /government/get-involved/take-part/volunteer                                                              |
            | National Citizen Service                                      | /government/get-involved/take-part/national-citizen-service                                               |
            | Start a public service mutual                                 | /government/get-involved/take-part/start-a-public-service-mutual                                          |
            | Set up a new school                                           | /government/get-involved/take-part/set-up-a-new-school                                                    |
            | Help make your neighbourhood a safer place                    | /government/get-involved/take-part/help-make-your-neighbourhood-a-safer-place                             |
            | Decide where homes, shops and businesses should be built      | /government/get-involved/take-part/decide-where-new-homes-shops-facilities-and-businesses-should-be-built |
            | Challenge to run a local service                              | /government/get-involved/take-part/challenge-to-run-a-local-service                                       |
            | Improve your social housing                                   | /government/get-involved/take-part/improve-your-social-housing                                            |
            | Protect a local building                                      | /government/get-involved/take-part/protect-a-local-building                                               |
            | Organise a street party                                       | /government/get-involved/take-part/organise-a-street-party                                                |
            | Take over a local pub, shop, or green space for the community | /government/get-involved/take-part/take-over-a-local-pub-shop-or-green-space-for-the-community            |
            | Volunteer as a school governor                                | /become-school-college-governor                                                                           |
            | Set up a town or parish council                               | /government/get-involved/take-part/set-up-a-town-or-parish-council                                        |
            | Invest in local enterprises                                   | /government/get-involved/take-part/invest-in-local-enterprises                                            |
            | Help run a charity                                            | /government/get-involved/take-part/help-run-a-charity                                                     |
            | Make a neighbourhood plan                                     | /government/get-involved/take-part/make-a-neighbourhood-plan                                              |
            | Create a community library                                    | /government/get-involved/take-part/create-a-community-library                                             |
            | Become a councillor                                           | /government/get-involved/take-part/become-a-councillor                                                    |