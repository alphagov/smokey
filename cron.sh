#!/bin/sh

#
# Smokey cronjob. This should be run with suitable mutex protection, e.g.
#
#     /usr/local/bin/lockrun -L /var/run/smokey.lock -q -- /opt/smokey/cron.sh
#

set -e

cd $(dirname "$0")

[ -e /etc/smokey.sh ] && . /etc/smokey.sh

for feature in $(find features -name "*.feature"); do
  bundle exec ./run_feature.sh "$feature" >/dev/null 2>&1
done

