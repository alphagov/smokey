#!/usr/bin/env python
import json, sys, os, codecs
from pprint import pprint
from time import gmtime, strftime, time
from syslog import *
from cStringIO import StringIO

def log_result_to_syslog(exitcode, message):
    if exitcode == 3:
        log_priority = LOG_ERR
    elif exitcode == 2:
        log_priority = LOG_CRIT
    elif exitcode == 1:
        log_priority = LOG_WARN
    else:
        log_priority = LOG_NOTICE
    syslog(log_priority, "CHCK | %s@%s | %s" % (sys.argv[1], sys.argv[2], message))


def log_result_and_exit(exitcode,message):
    log_result_to_syslog(exitcode, message)

    # nagios reads the printed msg for status
    # (http://nagios.sourceforge.net/docs/3_0/pluginapi.html)
    print message
    sys.exit(exitcode)

class FeatureTestRun(object):

    def __init__(self, feature_uri, json_data, priority, logfile):
        self.feature_found = False
        self.passed = 0
        self.skipped = 0
        self.failed = 0
        self.log = ""
        self.walk_json_tree_of_features(feature_uri, json_data, priority)
        self.write_pretty_log(logfile)

    # Walk the json tree of features
    def walk_json_tree_of_features(self, feature_uri, json_data, priority):
        result_details = StringIO()

        for feature in json_data:
            if feature['uri'] == feature_uri:
                # Yay, we have found the right feature
                self.feature_found = True
                self.passed = 0
                self.skipped = 0
                self.failed = 0
                # Walk through the scenarios in the feature
                if 'elements' not in feature:
                    log_result_and_exit(0, "OK: Feature %s has no steps at any priority" % feature_name)

                for scenario in feature['elements']:
                    if 'tags' in scenario:
                        for tag in scenario['tags']:
                            # If the scenario matches our tag, then check the output
                            if tag['name'] == priority:
                                # Write out a header to our log
                                result_details.write(
                                    "%s:  Scenario: %s (%s/%s)\n" % (runtime, scenario['name'], feature['uri'], priority))
                                for step in scenario['steps']:
                                    message = ""
                                    if step['result']['status'] == 'passed':
                                        self.passed += 1
                                    elif step['result']['status'] == 'skipped':
                                        self.skipped += 1
                                    else:
                                        self.failed += 1
                                        # Only failures have messages
                                        message = step['result']['error_message']
                                        # Write out the step description and the status
                                    result_details.write("%s:    Step: [%s] %s%s\n" % (
                                        runtime, step['result']['status'].upper()[:4], step['keyword'], step['name']))
                                    syslog(LOG_NOTICE, "%s | %s%s | %s | %s%s" % (
                                        step['result']['status'].upper()[:4], feature['uri'].split('/')[1].split('.')[0],
                                        priority, scenario['name'], step['keyword'], step['name'].encode("ascii", "ignore")))
                                    # If we have any rows (e.g. perhaps lists of URLs to visit, write them too)
                                    if 'rows' in step:
                                        for row in step['rows']:
                                            result_details.write("%s:              " % runtime)
                                            for cell in row['cells']:
                                                result_details.write("%s " % cell)
                                            result_details.write("\n")
                                            # If we encountered a failure, write out the error
                                    if message != "":
                                        result_details.write("%s:      Error: %s\n" % (runtime, message.partition('\n')[0]))
                                        syslog(LOG_NOTICE, "%s | %s%s | %s | %s%s | Error - %s" % (
                                            step['result']['status'].upper()[:4], feature['uri'].split('/')[1].split('.')[0],
                                            priority, scenario['name'], step['keyword'], step['name'].encode("ascii", "ignore"),
                                            message.partition('\n')[0]))
                                # A blank line to make our log pretty
                                result_details.write("%s:\n" % runtime)
                                self.log = result_details.getvalue()


    def write_pretty_log(self, logfile):
        pplog = codecs.open(logfile, "a", "utf-8-sig")
        pplog.write(self.log)
        pplog.close()


def argument_check():
    if len(sys.argv) != 4:
        log_result_and_exit(3, "UNKNOWN: Usage: nagios_check_cache.py feature priority jsonfile")


def argument_sanity_checks(json_file):
    # Check whether the json file exists and issue UNKNOWN if not
    if os.path.exists(json_file) == False:
        log_result_and_exit(3, "UNKNOWN: %s does not exist" % json_file)

    # Check the age of the json file is less than 30m and issue UNKNOWN if not
    json_age = time() - os.stat(json_file).st_mtime
    if json_age > 1800:
        log_result_and_exit(3, "UNKNOWN: %s is older than 30m" % json_file)


def ensure_log_directory_exists(log_dir):
    if not os.path.exists(log_dir):
        os.makedirs(log_dir)


def main():
    argument_check()
    feature_name = sys.argv[1]
    priority = "@" + sys.argv[2]
    json_file = sys.argv[3]
    argument_sanity_checks(json_file)
    smokey_log_dir = os.path.dirname(os.path.abspath(sys.argv[0])) + '/log/'
    openlog("smokey", 0, LOG_DAEMON)

    #  set some variables
    smokey_json = json.loads(open(json_file).read())
    feature_uri = 'features/' + feature_name + '.feature'
    logfile = smokey_log_dir + feature_name + '_' + sys.argv[2] + '.log'
    ensure_log_directory_exists(smokey_log_dir)
    # Parse the json into valuble information
    feature_test_run = FeatureTestRun(feature_uri, smokey_json, priority, logfile);
    # We didn't even find this feature in the steps!
    if not feature_test_run.feature_found:
        log_result_and_exit(0, "OK: But feature %s was not found" % feature_name)

    # Check the output of our tests
    if feature_test_run.failed > 0:
        status = "CRITICAL"
        exitcode = 2
    elif feature_test_run.skipped > 0:
        status = "WARNING"
        exitcode = 1
    elif feature_test_run.passed > 0:
        status = "OK"
        exitcode = 0
    else:
        # We use this exitcode later
        exitcode = 99

    # Assuming we had a non-zero number of checks, lets spit out Nagios output
    if exitcode != 99:
        log_result_and_exit(exitcode, "%s: %s failed, %s skipped, %s passed; \n\n%s" % (
        status, feature_test_run.failed, feature_test_run.skipped, feature_test_run.passed, feature_test_run.log))

    # We had no steps, but did the feature at least exist?
    if feature_test_run.feature_found:
        log_result_and_exit(0, "OK: But no %s tests for %s found" % (priority, feature_name))
    else:
        log_result_and_exit(3, "UNKNOWN: Something went very wrong")


if __name__ == '__main__':
    runtime = strftime("%Y-%m-%d %H:%M:%S", gmtime())
    main()
