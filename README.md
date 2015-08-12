# GOV.UK Smoke Tests

Automated tests that describe high level user journeys which touch multiple
applications within the GOV.UK stack.

These are used to verify releases and also to provide Nagios alerts for major
features.

## Technical documentation

The smoke tests are based on [Cucumber](http://cukes.info/). We use feature
files to describe single applications (eg
[`whitehall`](https://github.com/alphagov/whitehall),
[`frontend`](https://github.com/alphagov/frontend)).

### Running the tests

Run the suite with:

```
bundle exec rake
```

or against a single `feature`:

```
bundle exec cucumber features/frontend.feature
```

The tests will run against the preview environment by default.  You can
override that by setting the `GOVUK_WEBSITE_ROOT` environment variable.

You may also specify the domain of the draft website root using
`GOVUK_DRAFT_WEBSITE_ROOT`. By default this will use the url for `draft-
origin` returned by [`plek`](http://github.com/alphagov/plek).

You'll need to configure the http auth credentials by setting the
`AUTH_USERNAME` and `AUTH_PASSWORD` environment variables.

    GOVUK_WEBSITE_ROOT=https://hostname AUTH_USERNAME=username AUTH_PASSWORD=password bundle exec rake

### Adding new tests

Tests that are supposed to be run by icinga also have to be added to the file
`modules/monitoring/manifests/checks/smokey.pp` in our Puppet repository. For
example, the test [frontend.feature](/features/frontend.feature)
is added to icinga like this:

```puppet
icinga::check_feature {
  'check_frontend':          feature => 'frontend';
  #other feature tests
}
```

### Prioritising scenarios

Because we integrate Nagios with the output from these tests, we provide a set
of tags which match with how important we consider a scenario to be. `@high` and
above will trigger pager alerts.

Each scenario can and should be prioritised by using the `@urgent`, `@high`,
`@normal` or `@low` cucumber tags. For example, the frontend scenario "check
guides load" can be prioritised like this:

```cucumber
@low
Scenario: check guides load
  When I visit "/getting-an-mot/overview"
  Then I should see "Getting an MOT"
```
