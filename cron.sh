#!/bin/bash

if [ -f /tmp/smokey_running ]; then
  echo "Smokey is already running"
  exit 1
fi

touch /tmp/smokey_running;
cd /opt/smokey;
source /etc/smokey.sh

for i in `find features -name "*.feature"`; do
  bundle exec ./run_feature.sh $i &
  sleep 5
done;
# Let all the subcommands spin up
sleep 10

while [ "`find /tmp -name 'smokey_running_*' 2>/dev/null`" != "" ]; do
  sleep 10;
done
rm /tmp/smokey_running
