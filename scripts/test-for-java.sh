#!/bin/bash

set -e

SONAR_SOURCE_DIR=.

workspaces=( $(jq -r '.workspaces[]' "${SONAR_SOURCE_DIR}/package.json") )

for filepath in "${workspaces[@]}" ; do
if test -n "$(find ${filepath} -maxdepth 15 -name '*.java' -print -quit)"
then
    echo ${filepath}
    SONAR_JAVA_OPTS="-Dsonar.java.binaries=${filepath}/build/classes/java/main \
                   -Dsonar.java.test.binaries=${filepath}/build/classes/java/test \
                   -Dsonar.java.source=11"
    echo ${SONAR_JAVA_OPTS}
fi

done

