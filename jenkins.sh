#!/bin/bash

# Used by the Smokey job in Jenkins to do a one-off run
# of the Cucumber tests, with some flags to restrict the
# set of tests by environment and (optionally) by app.

set -x

bundle install --path "${HOME}/bundles/${JOB_NAME}" --deployment

export RESTCLIENT_LOG="log/smokey-rest-client.log"
export ENVIRONMENT=${TARGET_PLATFORM}

FLAGS=(--profile "${TARGET_PLATFORM}")
FLAGS+=(--strict-undefined)

if [ -n "${TARGET_APPLICATION}" ]; then
  FLAGS+=(-t "@app-${TARGET_APPLICATION}")
fi

govuk_setenv smokey bundle exec cucumber "${FLAGS[@]}"
