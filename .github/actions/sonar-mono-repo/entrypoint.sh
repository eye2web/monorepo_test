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

if [[ -z "${ROOTDIR}" ]]; then
  echo "This GitHub Action ROOTDIR not set, referting to default '.'"
  ROOTDIR="."
fi

if [[ -f "${ROOTDIR%/}package.json" ]]; then
  echo "The given project root does not contain a package.json."
  exit 1
fi



workspaces=( $(jq -r '.workspaces[]' "${ROOTDIR%/}package.json") )

for filepath in "${workspaces[@]}" ; do
    COMPONENT_NAME=( $(jq -r '.name' ${filepath}/package.json) )
    echo sonar-scanner -Dsonar.projectBaseDir=${filepath} -Dsonar.projectName="${SONAR_PROJECT_NAME} - ${COMPONENT_NAME}" -Dsonar.projectKey=${INPUT_SONAR_PROJECTKEY} ${INPUT_ARGS} 
done
