#! /bin/bash

source scripts/CommonLib.sh

# Building docker test images
printTitleWithColor "building docker images" "${yellow}"
printMessage "Building docker init image"
dockerBuild DockerfileInit "itestinit:test"
printMessage "Building docker integration test image"
dockerBuild DockerfileItest "itest:test"

# Starting infra
ls -als
pwd
docker-compose down
printTitleWithColor "Starting infra" "${yellow}"
docker-compose up -d || exitOnError "error starting infra"

# wait
sleep 4

# run tests
path=$(pwd)
mkdir $path/reporting
printTitleWithColor "Running Itests" "${yellow}"
getNetworkNameFromDockerCompose
docker run -i --network=$networkName -v $path/reporting:/reporting itest:test || printAlert "some tests fail, please check reporting"

# Stopping infra
printTitleWithColor "Stopping infra" "${yellow}"
docker-compose down || exitOnError "error stopping infra"
