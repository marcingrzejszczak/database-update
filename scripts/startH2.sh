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
    echo "Running H2 from [${H2_FOLDER}]"
    nohup ${H2_FOLDER}/h2.sh > target/h2.log &
    pid=$!
    echo $pid > target/h2.pid
    echo "H2 process pid is [$pid]"
    echo "H2 process pid file is here [target/h2.pid]"
    echo "H2 logs are present under [target/h2.log]"
else
    echo "H2 is already running. Check the PID"
    cat target/h2.pid
fi
