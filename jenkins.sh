#!/bin/bash -x

bundle install --path "${HOME}/bundles/${JOB_NAME}" --deployment
RESTCLIENT_LOG="log/smokey-rest-client.log" bundle exec rake test:localnetwork
