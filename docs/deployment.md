# Deployment

This app only has minimal CI set up, running a single check to ensure that Smokey is able to make requests. It would be misleading to run all of the tests on CI because their behaviour changes depending on the environment they are run in. You should manually test in applicable environments, until you are confident your change is not a breaking one.

Example steps to test in Integration:

- Navigate to the [Deploy GitHub Action](https://github.com/alphagov/smokey/actions/workflows/deploy.yml) tab on the repo
- Click “Run workflow” and enter the name of the branch under "Commit, tag or branch name to deploy". (NB: leave the "Use workflow from" option set as main)
- Wait for the Deploy job to succeed
- Wait for the ["sync status" in Argo CD](https://argo.eks.integration.govuk.digital/applications/cluster-services/smokey) to update (it will take several minutes) - or speed things along by clicking the "Sync" button at the top of the page
- Wait for a Smokey run to be triggered (happens every 10 minutes), or speed things along by clicking the [three dots by the 'smokey' cronjob -> Create Job](https://argo.eks.integration.govuk.digital/applications/cluster-services/smokey?node=batch%2FCronJob%2Fapps%2Fsmokey%2F0&orphaned=false&resource=).
- Check the results from the logs

If the build passes, you can merge, and Argo CD will automatically update itself back to `main`.

If the build fails, then there may be a problem with the PR. You'll have to revert the branch deploy by following the "Run workflow" instructions above, but using "main" instead of the branch name.
