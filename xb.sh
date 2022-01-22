#!/usr/bin/env bash

source .setupenv

DOCKER="docker run --env TARGET_NAME=${TARGET_NAME} --volume ${VOL_NAME}:/home/docker/host mbd1/stm32_buildtools"

build() {
    cd $TOP
    rm -rf $BUILD_PATH && mkdir $_ && cd $_
    $DOCKER cmake -Bbuild -DCMAKE_TOOLCHAIN_FILE=toolchain.cmake
    $DOCKER make -C build -j12 && cd $TOP
}

build