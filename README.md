Some fairly basic smoke tests that test the deployed versions of the single 
domain apps.

## Running the tests

The tests will run against the preview environment by default.  You can 
override that by setting the `TARGET_PLATFORM` environment variable.

You'll need to configure the http auth credentials by setting the 
`AUTH_USERNAME` and `AUTH_PASSWORD` environment variables.

    TARGET_PLATFORM=preview AUTH_USERNAME=username AUTH_PASSWORD=password bundle exec rake

## Adding new tests

Tests that are supposed to be run by nagios also have to be added to the file 
modules/nagios/manifests/config.pp in the puppet repository. For example, the 
test features/apollo.feature is added to nagios like this:

    nagios::check_feature {
      'check_apollo':          feature => 'apollo';
      #other feature tests
    }

## Prioritising scenarios

Each scenario can and should be prioritised by using the @urgent, @high, 
@normal or @low cucumber tags. For example, the frontend.feature scenario "check 
guides load" can be prioritised like this:

    @low
    Scenario: check guides load
      When I visit "/getting-an-mot/overview"
      Then I should see "Getting an MOT"

