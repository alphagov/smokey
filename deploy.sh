#!/bin/sh
set -eu

DEPLOY_TO="monitoring.management.production"

for server in $DEPLOY_TO; do
    chmod 777 log
    rsync -av --delete --exclude='.git' --exclude 'log/*' "$(pwd)/" "deploy@${server}":/opt/smokey
    ssh deploy@${server} 'cd /opt/smokey && bundle install --path $HOME/.bundle/gems --deployment'
done
logger -p INFO -t jenkins "DEPLOYMENT: ${JOB_NAME} ${BUILD_NUMBER} (${BUILD_URL})"
