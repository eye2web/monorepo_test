#! /bin/bash
set -e
# Current directory
echo "Building docker image"
echo "The current directory is: ["
pwd
echo "]"
DOCKER_REPOSITORY=""
DOCKER_FILE=.
# Get input parameters
while getopts v:t:r:f: flag
do
    case "${flag}" in
        v) COMPONENT_VERSION=${OPTARG};;
        t) COMPONENT_NAME=${OPTARG};;
        r) DOCKER_REPOSITORY=${OPTARG};;
        f) DOCKER_FILE=${OPTARG};;
    esac
done

echo "Building docker image with name: ($DOCKER_REPOSITORY$COMPONENT_NAME:$COMPONENT_VERSION)"
docker build --build-arg version=${COMPONENT_VERSION} --build-arg name=${COMPONENT_NAME} -t $DOCKER_REPOSITORY$COMPONENT_NAME:$COMPONENT_VERSION $DOCKER_FILE