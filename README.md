# GOV.UK Smoke Tests

A suite of [Cucumber](https://cucumber.io/) tests that probe GOV.UK frontend and backend publishing functionality. We use feature files to describe single applications (eg [`whitehall`](https://github.com/alphagov/whitehall), [`frontend`](https://github.com/alphagov/frontend)) or [cross-application behaviour](features/gov_uk.feature). The tests [use Selenium to manipulate a headless Chrome browser](features/support/env.rb).

The tests are run in two different ways:

- On demand, to check if a change breaks something. This is done using the [Smokey job in Jenkins](https://github.com/alphagov/govuk-puppet/blob/b103dd3b4adcc8c39343dd85b68f4f5b93e38d9d/modules/govuk_jenkins/manifests/jobs/smokey.pp) when deploying GOV.UK applications, [Puppet](https://github.com/alphagov/govuk-puppet/blob/27faad21eadd52e8d8b37366eac0d8e1e123adbb/modules/govuk_jenkins/templates/jobs/deploy_puppet.yaml.erb#L44) and other code, such as [CDN config](https://github.com/alphagov/govuk-puppet/blob/0e1f84954831188e22a1a76cedc4463318edf1e8/modules/govuk_jenkins/templates/jobs/deploy_cdn.yaml.erb#L49).

- Periodically, to check for transient failures e.g. in infrastructure. The tests are run in [a continuous "Smokey Loop"](https://github.com/alphagov/govuk-puppet/blob/b4db7542789ecff278ae7defc05f7652f7077806/modules/monitoring/templates/smokey-loop.conf), with [corresponding alerts in Icinga](https://github.com/alphagov/govuk-puppet/blob/b4db7542789ecff278ae7defc05f7652f7077806/modules/monitoring/manifests/checks/smokey.pp).

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
- [pr-template](.github/pull_request_template.md)
