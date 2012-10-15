#!/bin/bash

if [ -f /tmp/smokey_running ]; then
  echo "Smokey is already running"
  exit 1
fi

touch /tmp/smokey_running
cd /opt/smokey;

source /etc/smokey.sh

if [ x$2 = xunprio ]; then
  ARG="-t ~@high -t ~@medium -t ~@low"
else
  ARG="-t @$2"
fi

for i in `find features -name "*.feature"`; do
  for priority in urgent high medium normal low unprio; do
    if [ "x${priority}" != "xunprio" ]; then
      runpriority="-t @${priority}";
    else
      runpriority="-t ~@high -t ~@medium -t ~@low";
    fi
    tmpfeature=${i##*/}
    feature=${tmpfeature%%.*}
    bundle exec cucumber $i --format Cucumber::Formatter::Nagios -t ~@pending -t ~@notnagios $runpriority > /tmp/smokey_${feature}_${priority}
  done;
done;

rm /tmp/smokey_running
