# Tagging

`@...` tags should _only_ be used for filtering ([not functionality hooks](https://github.com/alphagov/smokey/pull/903)).

## `@app-<app_name>`

The Smokey job in Jenkins [has an option to filter scenarios by application](https://github.com/alphagov/govuk-puppet/blob/7f4b1684471daf09cff72c1372db88b1ed3fd1dc/modules/govuk_jenkins/templates/jobs/smokey.yaml.erb#L34), so that we can avoid running the entire test suite when only some scenarios are relevant to a change. To associate tests with an app, you need to tag the relevant scenarios (or entire feature) with `@app-<app_name>`.

**Important: make sure `<app_name>` matches against [the list of apps for the Deploy_App job](https://github.com/alphagov/govuk-puppet/blob/7f4b1684471daf09cff72c1372db88b1ed3fd1dc/hieradata_aws/common.yaml#L145)**. This is so the filtering will work with [the Continuous Deployment pipeline](https://github.com/alphagov/smokey/pull/675).

## `@not<environment>`

All features should run in **all** environments. Sometimes this isn't possible e.g.

- [The actual functionality only exists in Production](https://github.com/alphagov/smokey/blob/83fa09aa2aacec3053d58c52a2cb3af1ca27ba2b/features/mirror.feature). Tag the feature or scenario with `@notintegration` and `@notstaging` so it doesn't run in these environments i.e. its only runs in Production.

- [The functionality is being replatformed](https://github.com/alphagov/smokey/blob/5caf9635f4c4601df69c39075f5438fc3d3f3df0/features/info_frontend.feature#L1). Tag the feature or scenario with `@replatforming` or `@notreplatforming` depending on whether you expect it to work in the new platform.

## `@pending`

This will stop a feature or scenario from running in all environments.

**Only use this tag if you know you will re-enable it soon**. Otherwise, it's clearer to just remove it - either way you will need to make a PR to restore it, so the amount of work is similar.

## `@local-network`

This will stop a feature or scenario running on a local machine. Use this tag if there's a network policy in place that prevents your local machine from accessing protected functionality.

**Before adding this tag, check if you could write a better test.** It's hard to maintain tests that can't be run locally, so only use this tag if there's no practical way to fix the access issue.
