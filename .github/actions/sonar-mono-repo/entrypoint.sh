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

if [[ -f "${INPUT_ROOTDIR%/}package.json" ]]; then
  echo "The given project root does not contain a package.json."
  exit 1
fi




# sonar-scanner -Dsonar.projectBaseDir=${} ${INPUT_ARGS} 