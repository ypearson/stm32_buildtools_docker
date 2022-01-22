FROM ubuntu:20.04

# Create docker user with sudo
RUN apt-get update
RUN DEBIAN_FRONTEND=noninteractive TZ=Etc/UTC apt-get -yq install tzdata
RUN apt-get install -yq sudo
RUN adduser --disabled-password --gecos '' docker
RUN echo '%sudo ALL=(ALL) NOPASSWD:ALL' >> /etc/sudoers
RUN adduser docker sudo
USER docker

# Install ARM toolchain, and build tools
WORKDIR /home/docker
RUN mkdir host
RUN sudo apt-get update
RUN sudo apt-get install -yq build-essential cmake wget
ARG ARM_PATH=/home/docker/arm
RUN mkdir ${ARM_PATH}
WORKDIR ${ARM_PATH}
RUN wget https://developer.arm.com/-/media/Files/downloads/gnu-rm/9-2020q2/gcc-arm-none-eabi-9-2020-q2-update-x86_64-linux.tar.bz2
RUN tar --strip-components=1 -xvjf gcc-arm-none-eabi-9-2020-q2-update-x86_64-linux.tar.bz2

WORKDIR /home/docker/host
# Set toolchain in path
ENV PATH="${ARM_PATH}/bin:${PATH}"