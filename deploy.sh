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
    rsync -av --delete --exclude='.git' "$(pwd)/" "deploy@${server}":/opt/smokey
done 
