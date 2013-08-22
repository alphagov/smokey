Feature: Contracts Finder

@low
Scenario: contracts finder availability
  Given I am testing "http://online.contractsfinder.businesslink.gov.uk"
  Then I should be able to visit:
    | Path                                            |
    | /                                               |
    | /Help%20and%20Resources.aspx?site=1000&lang=en  |
    | /Search%20Contracts.aspx?site=1000&lang=en      |

@low
Scenario: contracts finder search
  Given I am testing "http://online.contractsfinder.businesslink.gov.uk"
  When I do a search for consultancy in the See Live Opportunities Section
  Then I should see some contracts finder results

@low
Scenario: contracts finder government purchases
  Given I am testing "http://online.contractsfinder.businesslink.gov.uk/"
  When I do a search for computer in the what's being bought by government
  Then I should see some contracts finder results
