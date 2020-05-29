#!/bin/sh

set -x

bundle install --path "${HOME}/bundles/${JOB_NAME}" --deployment

export RESTCLIENT_LOG="log/smokey-rest-client.log"
export ENVIRONMENT=${TARGET_PLATFORM}

FLAGS="--profile ${TARGET_PLATFORM}"

if [ -n "${TARGET_APPLICATION}" ]; then
  FLAGS="${FLAGS} -t @app-${TARGET_APPLICATION}"
fi

govuk_setenv smokey bundle exec cucumber $FLAGS
