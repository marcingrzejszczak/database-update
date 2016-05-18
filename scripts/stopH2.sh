#!/usr/bin/env bash

CURRENT_FOLDER=`pwd`
if [[ ! -e "${CURRENT_FOLDER}/h2" ]]; then
    cd ..
    CURRENT_FOLDER=`pwd`
    if [[ ! -e "${CURRENT_FOLDER}/h2" ]]; then
        echo "No h2 folder found"
        exit 1
    fi
fi

mkdir -p target
H2_FOLDER="${CURRENT_FOLDER}/h2"

if [[ ! -e "${CURRENT_FOLDER}/target/h2.pid" ]]; then
    echo "Can't stop h2 since it's not running"
else
    echo "H2 PID:"
    cat "${CURRENT_FOLDER}/target/h2.pid"
    pid=`ps | grep h2-1.3.176 | awk 'NR==1{print $1}' | cut -d' ' -f1`
    kill -9 $pid && echo "Killed the jar process with H2" || echo "There was no h2 process running"
    rm target/h2.pid
fi
