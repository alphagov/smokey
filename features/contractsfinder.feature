Feature: Contracts Finder

@high
Scenario: contracts finder availability
  Given I am testing "http://www.contractsfinder.businesslink.gov.uk"
  Then I should be able to visit:
    | Path    |
    | /       |
    | /help   |
    | /search |

@high
Scenario: contracts finder search
  Given I am testing "http://www.contractsfinder.businesslink.gov.uk"
  When I do a search for consultancy in the See Live Opportunities Section
  Then I should see some results

@high
Scenario: contracts finder government purchases
  Given I am testing "http://www.contractsfinder.businesslink.gov.uk/"
  When I do a search for computer in the what's being bought by government
  Then I should see some results
