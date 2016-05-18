#!/usr/bin/env bash

source common.sh || source scripts/common.sh || echo "No common.sh script found..."

set -e

for D in `find . -type d -name 'boot-flyway-v*'`
do
    echo "Building [$D]"
    cd $D
    ./mvnw clean package
    cd ..
done