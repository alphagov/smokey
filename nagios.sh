#!/bin/bash

cd /opt/smokey;

source /etc/smokey.sh

if [ x$2 = xunprio ]; then
  ARG="-t ~@urgent -t ~@high -t ~@normal -t ~@low"
else
  ARG="-t @$2"
fi

bundle exec cucumber features/$1.feature --format Cucumber::Formatter::Nagios -t ~@pending -t ~@notnagios $ARG

