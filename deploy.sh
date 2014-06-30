#!/bin/sh
set -eu

# Check if DEPLOY_TO is not empty. The starting colon is not an accident
# See: http://stackoverflow.com/questions/307503/whats-the-best-way-to-check-that-environment-variables-are-set-in-unix-shellscr
: ${DEPLOY_TO:?"Need to set DEPLOY_TO env var to non-empty"}

chmod 777 log
rsync -av --delete --exclude='.git' --exclude 'log/*' "$(pwd)/" "deploy@${DEPLOY_TO}":/opt/smokey
ssh deploy@${DEPLOY_TO} 'cd /opt/smokey && bundle install --path $HOME/.bundle/gems --deployment'

logger -p INFO -t jenkins "DEPLOYMENT: ${JOB_NAME} ${BUILD_NUMBER} (${BUILD_URL})"
