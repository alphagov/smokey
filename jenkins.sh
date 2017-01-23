#!/bin/sh

set -x

# Clean up untracked files. This is mainly to remove `smokey-rest-client.log`,
# otherwise it builds up between jobs.
git clean -fdx

if [ -z $MYTASK ]; then
  MYTASK="test:production"
fi

# This removes rbenv shims from the PATH where there is no
# .ruby-version file. This is because certain gems call their
# respective tasks with ruby -S which causes the following error to
# appear: ruby: no Ruby script found in input (LoadError).
if [ ! -f .ruby-version ]; then
  export PATH=$(printf $PATH | awk 'BEGIN { RS=":"; ORS=":" } !/rbenv/' | sed 's/:$//')
fi

bundle install --path "${HOME}/bundles/${JOB_NAME}" --deployment
RESTCLIENT_LOG="log/smokey-rest-client.log" govuk_setenv default xvfb-run -a bundle exec rake $MYTASK
