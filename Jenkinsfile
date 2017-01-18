#!/usr/bin/env groovy

REPOSITORY = 'content-tagger'
DEFAULT_SCHEMA_BRANCH = 'deployed-to-production'

node {
  def govuk = load '/var/lib/jenkins/groovy_scripts/govuk_jenkinslib.groovy'

  properties([
    buildDiscarder(
      logRotator(
        numToKeepStr: '50')
      ),
    [$class: 'RebuildSettings', autoRebuild: false, rebuildDisabled: false]
    ],
  ])

  try {
    if (!govuk.isAllowedBranchBuild(env.BRANCH_NAME)) {
      return
    }

    stage("Checkout") {
      checkout scm
    }

    stage("Clean up workspace") {
      govuk.cleanupGit()
    }

    stage("git merge") {
      govuk.mergeMasterBranch()
    }

    stage("Configure environment") {
      govuk.setEnvar("GOVUK_WEBSITE_ROOT", "https://www.gov.uk")
    }

    stage("bundle install") {
      govuk.bundleApp()
    }

    stage("Run tests") {
      govuk.runRakeTask("test:production")
    }

  } catch (e) {
    currentBuild.result = "FAILED"
    step([$class: 'Mailer',
          notifyEveryUnstableBuild: true,
          recipients: 'govuk-ci-notifications@digital.cabinet-office.gov.uk',
          sendToIndividuals: true])
    throw e
  }
}
