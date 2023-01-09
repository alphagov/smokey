# Deployment

## Before you merge

This app only has minimal CI set up, running a single check to ensure that Smokey is able to make requests. It would be misleading to run all of the tests on CI because their behaviour changes depending on the environment they are run in. You should manually test in applicable environments, until you are confident your change is not a breaking one.

Example steps to test in Integration:

- Click "Configure" for the [Smokey job][]
- Change the "Branch specifier" to the name of your branch
- Run a new build of the Smokey project and check the results

## After you merge

The manual [Smokey job][] (in every Jenkins environment) will pick up changes on `main` automatically.

[Smokey job]: https://deploy.integration.publishing.service.gov.uk/job/Smokey/
