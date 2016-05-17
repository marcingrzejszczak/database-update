#!/usr/bin/env bash

set -e

for D in `find . -type d -name 'boot-flyway-v*'`
do
    echo "Building [$D]"
    cd $D
    ./mvnw clean verify
    cd ..
done