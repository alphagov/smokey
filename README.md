# GOV.UK Smoke Tests

Automated tests that describe high level user journeys which touch multiple
applications within the GOV.UK stack.

The master branch of the tests is frequently run in all environments, triggered by deployments of most GOV.UK applications, CDNs and associated dependencies ([check here](https://github.com/alphagov/govuk-puppet/search?l=HTML%2BERB&q=smokey)).

The tests also run in [a continuous Smokey loop](https://github.com/alphagov/govuk-puppet/blob/master/modules/monitoring/templates/smokey-loop.conf), using a version of the master branch [deployed by Jenkins each day](https://github.com/alphagov/govuk-puppet/blob/master/modules/govuk_jenkins/templates/jobs/smokey_deploy.yaml.erb). We use the Smokey loop to provide Icinga alerts for major features.

## Technical documentation

You can use the [GOV.UK Docker environment](https://github.com/alphagov/govuk-docker) to run the application and its tests with all the necessary dependencies. Follow [the usage instructions](https://github.com/alphagov/govuk-docker#usage) to get started.

**Use GOV.UK Docker to run any commands that follow.**

### Running the test suite

**Note: you will need to be connected to the VPN to test against Integration or Staging.**

The tests require additional configuration to run successfully on a local machine.

```
env \
ENVIRONMENT=integration \
SIGNON_EMAIL="<email-address>" \
SIGNON_PASSWORD="<password>" \
bundle exec cucumber
```

You can use the following environment variables to configure the tests:

* `ENVIRONMENT`: controls domains returned by [Plek](https://github.com/alphagov/plek) (see [env.rb](https://github.com/alphagov/smokey/blob/19c21ac4be3f67ef994f327670121209c8632c0d/features/support/env.rb#L9-L21))
* `SIGNON_EMAIL`: email of a Signon user in $ENVIRONMENT
* `SIGNON_PASSWORD`: password of a Signon user in $ENVIRONMENT

You can try using your own Signon account, but this won't work if you have Multi Factor Auth enabled. Another option is to use the credentials for the Smokey test user in `govuk-secrets/puppet_aws`:

```
bundle exec rake 'eyaml:decrypt_value[integration,smokey_signon_email]'
bundle exec rake 'eyaml:decrypt_value[integration,smokey_signon_password]'
```

## Layout

The smoke tests are based on [Cucumber](https://cucumber.io/) and [use Selenium to manipulate a headless Chrome browser](features/support/env.rb). We use feature
files to describe single applications (eg
[`whitehall`](https://github.com/alphagov/whitehall),
[`frontend`](https://github.com/alphagov/frontend)) or [cross-application behaviour](features/gov_uk.feature).

This repo also contains several scripts to support external systems running the tests and checking their output.

* `tests_json_output.sh`: used to run the Smokey loop and output JSON to a temporary file
* `nagios_check_cache.py`: used by Icinga to check for pass/fail statuses in the JSON in the temporary file
* `deploy.sh`: used by Jenkins to deploy Smokey in order to run the Smokey loop
* `jenkins.sh`: used by Jenkins to run a one-off Smokey e.g. after a deployment

## Further documentation

- [writing-tests](docs/writing-tests.md)
- [pr-template](.github/pull_request_template.md)
