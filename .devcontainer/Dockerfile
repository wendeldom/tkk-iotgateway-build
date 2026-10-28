FROM ubuntu:24.04

ARG DEBIAN_FRONTEND=noninteractive

RUN apt-get update && apt-get install -y build-essential chrpath \
cpio debianutils diffstat file gawk gcc git iputils-ping \
libacl1 libcrypt-dev locales python3 python3-git python3-jinja2 \
python3-pexpect python3-pip python3-subunit socat texinfo \
unzip wget xz-utils zstd bsdmainutils gcc-multilib git-lfs \
libgmp-dev libmpc-dev libsdl1.2-dev libssl-dev libusb-1.0-0 lz4 pylint xterm \
repo openssh-client \
&& rm -rf /var/lib/apt/lists/*

RUN locale-gen en_US.UTF-8
ENV LANG=en_US.UTF-8 \
LANGUAGE=en_US:en \
LC_ALL=en_US.UTF-8

USER ubuntu