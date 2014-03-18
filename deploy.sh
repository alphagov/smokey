#!/bin/sh
set -eu

if [ "$DEPLOY_TO" == "" ]; then
    DEPLOY_TO="monitoring.management.production"
fi

chmod 777 log
rsync -av --delete --exclude='.git' --exclude 'log/*' "$(pwd)/" "deploy@${DEPLOY_TO}":/opt/smokey
ssh deploy@${DEPLOY_TO} 'cd /opt/smokey && bundle install --path $HOME/.bundle/gems --deployment'

logger -p INFO -t jenkins "DEPLOYMENT: ${JOB_NAME} ${BUILD_NUMBER} (${BUILD_URL})"
