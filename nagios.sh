#!/bin/bash

cd /opt/smokey;

source /etc/smokey.sh

bundle exec cucumber features --format Cucumber::Formatter::Nagios -t ~@pending -t ~@notnagios
