#! /bin/bash
set -e

set_variables () {
    DOCKER_FILE=.

    ARTIFACTORY_HOST=https://artifactory-ehv.ta.philips.com
    ARTIFACTORY_REGISTRY=dl-research-hs-hemoguide-docker-local

    DOCKER_REGISTRY="${ARTIFACTORY_REGISTRY}.artifactory-ehv.ta.philips.com/"

    # Get input parameters
    while getopts h:r:k:t:v: flag
    do
        case "${flag}" in
            h) ARTIFACTORY_HOST=${OPTARG};;
            r) ARTIFACT_REGISTRY=${OPTARG};;
            k) ARTIFACTORY_API_KEY=${OPTARG};;
            t) COMPONENT_NAME=${OPTARG};;
            v) COMPONENT_VERSION=${OPTARG};;
            f) DOCKER_FILE=${OPTARG};;
        esac
    done
};

extract_packagejson_variables () {
    # Extract version number from package.json
    echo "Extracting component name from package.json"
    COMPONENT_NAME=$(node -pe 'JSON.parse(process.argv[1]).name' "$(cat package.json)")

    echo "Extracting component group from package.json"
    COMPONENT_GROUP=$(node -pe "(JSON.parse(process.argv[1]).group != undefined)? JSON.parse(process.argv[1]).group:'default'" "$(cat package.json)")

    if [ -z ${COMPONENT_VERSION+x} ]; then 
    echo "Extracting component version from package.json"
    COMPONENT_VERSION=$(node -pe 'JSON.parse(process.argv[1]).version' "$(cat package.json)")
    fi
};

check_artifactory_image () {
    echo "Checking if container ($COMPONENT_GROUP/$COMPONENT_NAME:$COMPONENT_VERSION) already exists"
    # Returns a json object that includes a list of versions (if exists)
    ARTIFACTORY_RESPONSE=$(curl -X GET $ARTIFACTORY_HOST/artifactory/api/docker/$ARTIFACTORY_REGISTRY/v2/$COMPONENT_NAME/tags/list -H X-JFrog-Art-Api:$ARTIFACTORY_API_KEY)

    # Returns true when version already exists in artifactory
    CONTAINS_VERSION=$(node -pe "let parsed = JSON.parse(process.argv[1]); (parsed.tags == undefined || !parsed.tags.includes(\"$COMPONENT_VERSION\"))? 'false':'true';" "$(echo $ARTIFACTORY_RESPONSE)")
    echo "Container ($COMPONENT_GROUP/$COMPONENT_NAME:$COMPONENT_VERSION) exists=($CONTAINS_VERSION)"
};

build_image () {
    # Build image
    echo "Building docker image with name: ($DOCKER_REPOSITORY$COMPONENT_NAME:$COMPONENT_VERSION)"
    docker build --build-arg version=${COMPONENT_VERSION} --build-arg name=${COMPONENT_NAME} -t "$DOCKER_REGISTRY$COMPONENT_GROUP/$COMPONENT_NAME:$COMPONENT_VERSION" $DOCKER_FILE
};

push_image () {
    # TODO push image to artifactory
    echo "TODO push image to artifactory"
};


set_variables
extract_packagejson_variables
check_artifactory_image
if [ "$CONTAINS_VERSION" == "true" ] && [ "$COMPONENT_VERSION" != "latest" ]; then
    echo "Image with ($COMPONENT_NAME:$COMPONENT_VERSION) already exist in artifactory. Skipping"
    exit 0;
fi

build_image
push_image
