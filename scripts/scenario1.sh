#!/usr/bin/env bash

source common.sh || source scripts/common.sh || echo "No common.sh script found..."

set -e

cat <<EOF
This Bash file will show you the scenario in which the app will be ran in version 1.0.0 and 2.0.0 simultaneously.
We will do it in the following way:

1) Run 1.0.0
2) Wait for the app (1.0.0) to boot
3) Generate a person by calling POST localhost:9991/person to version 1.0.0
4) Run 2.0.0
5) Wait for the app (2.0.0) to boot
6) Generate a person by calling POST localhost:9991/person to version 1.0.0
7) Generate a person by calling POST localhost:9992/person to version 2.0.0

EOF

echo -e "Ensure that all the apps are built and H2 is running!\n"
run_h2

echo -e "Starting app in version 1.0.0\n"
java_jar boot-flyway-v1 -Dspring.profiles.active=standalone

echo -e "Waiting for the app 1.0.0. to boot\n"
curl_local_health_endpoint 9991

echo -e "Generate a person in version 1.0.0\n"
generate_person 9991

echo -e "Starting app in version 2.0.0\n"
java_jar boot-flyway-v2 -Dspring.profiles.active=standalone

echo -e "Waiting for the app 2.0.0. to boot\n"
curl_local_health_endpoint 9992

echo -e "Generate a person in version 1.0.0\n"
generate_person 9991

echo -e "Generate a person in version 2.0.0\n"
generate_person 9992
