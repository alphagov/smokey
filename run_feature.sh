#!/bin/bash
tmpfeature=${1##*/}
feature=${tmpfeature%%.*}

if [ -f /tmp/smokey_running_${feature} ]; then
  echo "Smokey is already running"
  exit 1
fi

touch /tmp/smokey_running_${feature}

sleep $(($RANDOM/1000))

for priority in urgent high normal low unprio; do
    if [ "x${priority}" != "xunprio" ]; then
      runpriority="-t @${priority}";
    else
      runpriority="-t ~@urgent -t ~@high -t ~@normal -t ~@medium -t ~@low";
    fi
    #echo "running $feature $runpriority"
    cucumber $1 --format Cucumber::Formatter::Nagios -t ~@pending -t ~@notskyscape -t ~@notnagios $runpriority > /tmp/smokey_${feature}_${priority}
done;

rm /tmp/smokey_running_${feature}
