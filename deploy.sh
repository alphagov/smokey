#!/bin/sh
set -eu

case $GOVUK_PROVIDER in
  sky)
    DEPLOY_TO="monitoring.management.production"
  ;;
  *)
    case $DEPLOY_ENV in
      production)
        DEPLOY_TO="ec2-46-51-143-167.eu-west-1.compute.amazonaws.com"
      ;;
      preview)
        DEPLOY_TO="ec2-176-34-194-237.eu-west-1.compute.amazonaws.com"
      ;;
    esac
  ;;
esac

for server in $DEPLOY_TO; do
    chmod 777 log
    rsync -av --delete --exclude='.git' --exclude 'log/*' "$(pwd)/" "deploy@${server}":/opt/smokey
    ssh deploy@${server} 'cd /opt/smokey && bundle install --path $HOME/.bundle/gems --deployment'
done 
