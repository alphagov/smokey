# Writing tests

## Adding new tests

Tests that are supposed to be run by Icinga also have to be added to the file
`modules/monitoring/manifests/checks/smokey.pp` in the [govuk-puppet](https://github.com/alphagov/govuk-puppet) repository. For
example, the test [frontend.feature](/features/frontend.feature)
is added to Icinga like this:

```puppet
icinga::check_feature {
  'check_frontend':          feature => 'frontend';
  #other feature tests
}
```

## Prioritising scenarios

Because we integrate Icinga with the output from these tests, we provide a set
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
