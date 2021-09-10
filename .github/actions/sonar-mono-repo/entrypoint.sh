#!/bin/bash

set -e

if [[ -z "${SONAR_TOKEN}" ]]; then
  echo "This GitHub Action requires the SONAR_TOKEN env variable."
  exit 1
fi

if [[ -z "${SONAR_HOST_URL}" ]]; then
  echo "This GitHub Action requires the SONAR_HOST_URL env variable."
  exit 1
fi

if [[ -z "${SONAR_PROJECT_NAME}" ]]; then
  echo "This GitHub Action requires the SONAR_PROJECT_NAME env variable."
  exit 1
fi

if [[ -z "${SONAR_PROJECTKEY}" ]]; then
  echo "This GitHub Action requires the SONAR_PROJECTKEY env variable."
  exit 1
fi

if [[ -z "${SONAR_SOURCE_DIR}" ]]; then
  echo "This GitHub Action ROOTDIR not set, referting to default '.'"
  ROOTDIR="."
  ls -als
fi

if [[ -f "${SONAR_SOURCE_DIR%/}package.json" ]]; then
  echo "The given project root does not contain a package.json. ${SONAR_SOURCE_DIR%/}package.json"
  exit 1
fi


workspaces=( $(jq -r '.workspaces[]' "${SONAR_SOURCE_DIR}/package.json") )

unset JAVA_HOME

unset SONAR_JAVA_OPTS

if test -n "$(find ${filepath} -maxdepth 15 -name '*.java' -print -quit)"
then
    echo ${filepath}
    SONAR_JAVA_OPTS="-Dsonar.java.binaries=./build/classes/java/main \
                   -Dsonar.java.test.binaries=./build/classes/java/test \
                   -Dsonar.java.source=11"
fi

for filepath in "${workspaces[@]}" ; do
    COMPONENT_NAME=( $(jq -r '.name' ${filepath}/package.json) )
    echo sonar-scanner  \
      -Dsonar.projectBaseDir=${filepath} \
      -Dsonar.projectName="${SONAR_PROJECT_NAME}-${COMPONENT_NAME}" \
      -Dsonar.projectKey=${SONAR_PROJECTKEY} ${INPUT_ARGS} \
      ${SONAR_JAVA_OPTS}
done
