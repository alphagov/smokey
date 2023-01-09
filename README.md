# GOV.UK Smoke Tests

A suite of [Cucumber](https://cucumber.io/) tests that probe GOV.UK frontend and backend publishing functionality. The tests [use Selenium to manipulate a headless Chrome browser](features/support/env.rb).

The tests are run via a Jenkins job in each environment (e.g. [Integration](https://deploy.integration.publishing.service.gov.uk/job/Smokey/)).

The job is triggered in multiple ways:

- Every few minutes [via cron scheduler](https://github.com/alphagov/govuk-puppet/blob/278426769a1711c622bcb67a59175f73e8f4db61/modules/govuk_jenkins/manifests/jobs/smokey.pp#L24)
- On demand, to check if a change breaks something. This is done when deploying GOV.UK applications, [Puppet](https://github.com/alphagov/govuk-puppet/blob/27faad21eadd52e8d8b37366eac0d8e1e123adbb/modules/govuk_jenkins/templates/jobs/deploy_puppet.yaml.erb#L44) and other code, such as [CDN config](https://github.com/alphagov/govuk-puppet/blob/0e1f84954831188e22a1a76cedc4463318edf1e8/modules/govuk_jenkins/templates/jobs/deploy_cdn.yaml.erb#L49).

Each test should check that a critical area of GOV.UK is working as expected. [Read the guidance on what tests belong here and how to write new ones](docs/writing-tests.md).

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
* `RATE_LIMIT_TOKEN`: (optional) a token used to bypass rate limiting if present on apps.

You can try using your own Signon account, but this won't work if you have Multi Factor Auth enabled. Another option is to use the credentials for the Smokey test user in `govuk-secrets/puppet_aws`:

```
bundle exec rake 'eyaml:decrypt_value[integration,smokey_signon_email]'
bundle exec rake 'eyaml:decrypt_value[integration,smokey_signon_password]'
bundle exec rake 'eyaml:decrypt_value[integration,smokey_rate_limit_token]'
```

## Further documentation

- [deployment](docs/deployment.md)
- [tagging](docs/tagging.md)
- [writing tests](docs/writing-tests.md)
- [pr-template](.github/pull_request_template.md)

## Licence

[MIT License](LICENCE)
