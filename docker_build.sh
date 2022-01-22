#!/usr/bin/env bash

cd ..
source .setupenv

docker system prune -f -a
docker volume rm $VOL_NAME

# Create volume between host and docker container
docker volume create --driver local \
--opt type=none \
--opt device=$TOP \
--opt o=bind \
$VOL_NAME

# Build docker image from Dockerfile
docker build --tag mbd1/stm32_buildtools:latest Docker/
