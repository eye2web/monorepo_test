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
while getopts v:r:f: flag
do
    case "${flag}" in
        v) COMPONENT_VERSION=${OPTARG};;
        r) DOCKER_REPOSITORY=${OPTARG};;
        f) DOCKER_FILE=${OPTARG};;
    esac
done

# Extract version number from package.json
echo "Extracting component name from package.json"
COMPONENT_NAME=$(node -pe 'JSON.parse(process.argv[1]).name' "$(cat package.json)")

if [ -z ${COMPONENT_VERSION+x} ]; then 
echo "Extracting component version from package.json"
COMPONENT_VERSION=$(node -pe 'JSON.parse(process.argv[1]).version' "$(cat package.json)")
fi

echo "Building docker image with name: ($DOCKER_REPOSITORY$COMPONENT_NAME:$COMPONENT_VERSION)"
docker build -t $DOCKER_REPOSITORY$COMPONENT_NAME:$COMPONENT_VERSION $DOCKER_FILE