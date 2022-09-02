# Deployment

## Before you merge

This app doesn't have CI setup, and it would be misleading to do so: the behaviour of the tests changes depending on the environment they are run in. You should manually test in applicable environments, until you are confident your change is not a breaking one.

Example steps to test in Integration:

- Click "Configure" for the [Smokey job][]
- Change the "Branch specifier" to the name of your branch
- Run a new build of the Smokey project and check the results

## After you merge

The manual [Smokey job][] will pick up changes on `main` automatically and trigger a deploy to all environments.

The [continuous Smokey Loop][] is [deployed automatically by Jenkins](https://github.com/alphagov/govuk-puppet/blob/master/modules/govuk_jenkins/templates/jobs/smokey_deploy.yaml.erb) to all environments when changes are merged.

If you are adding a new feature file, you need to ensure the feature is [listed in the Puppet config for the Smokey Loop](https://github.com/alphagov/govuk-puppet/blob/d7af16e96aed682facb5cf5bc3e3972510c64ca2/hieradata_aws/integration.yaml#L378) in order to alert on a failing scenario in Icinga.

[Smokey job]: https://deploy.integration.publishing.service.gov.uk/job/Smokey/
[continuous Smokey Loop]: https://github.com/alphagov/govuk-puppet/blob/master/modules/monitoring/templates/smokey-loop.conf
