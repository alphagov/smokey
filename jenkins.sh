#!/bin/bash -x

if [ "$FACTER_govuk_provider" = "skyscape" ]; then
  MYTASK="test:skyscapenetwork"
else
  MYTASK="test:localnetwork"
fi
bundle install --path "${HOME}/bundles/${JOB_NAME}" --deployment
RESTCLIENT_LOG="log/smokey-rest-client.log" bundle exec rake $MYTASK
