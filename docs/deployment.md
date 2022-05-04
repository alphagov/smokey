# Deployment

## Before you merge

This app doesn't have CI setup, and it would be misleading to do so: the behaviour of the tests changes depending on the environment they are run in. You should manually test in applicable environments, until you are confident your change is not a breaking one.

Example steps to test in Integration:

- Click "Configure" for the [Smokey job][]
- Change the "Branch specifier" to the name of your branch
- Run a new build of the Smokey project and check the results

## After you merge

The manual [Smokey job][] will pick up changes on `main` automatically.

The [continuous Smokey Loop][] is [deployed daily by Jenkins](https://github.com/alphagov/govuk-puppet/blob/master/modules/govuk_jenkins/templates/jobs/smokey_deploy.yaml.erb) using `deploy.sh` and the latest version of the `main` branch. You should still consider manually deploying your change using the [Smokey deploy job][], in case it causes a problem.

[Smokey job]: https://deploy.integration.publishing.service.gov.uk/job/Smokey/
[continuous Smokey Loop]: https://github.com/alphagov/govuk-puppet/blob/master/modules/monitoring/templates/smokey-loop.conf
[Smokey deploy job]: https://deploy.integration.publishing.service.gov.uk/job/Smokey_Deploy/
