FROM p4lang/third-party:latest

ENV WORKDIR /workspaces/play-p4

ARG DEBIAN_FRONTEND=noninteractive
ENV LANGUAGE en_US.UTF-8
ENV LC_ALL en_US.UTF-8

# Basic setup
RUN apt-get update && apt-get install -y \
    apt-transport-https \
    build-essential \
    curl \
    git \
    gnupg \
    sudo \
    && rm -rf /var/lib/apt/lists/*

# Bazel
# https://bazel.build/install/ubuntu#install-on-ubuntu
RUN curl -fsSL https://bazel.build/bazel-release.pub.gpg | gpg --dearmor >bazel-archive-keyring.gpg \
    && sudo mv bazel-archive-keyring.gpg /usr/share/keyrings \
    && echo "deb [arch=amd64 signed-by=/usr/share/keyrings/bazel-archive-keyring.gpg] https://storage.googleapis.com/bazel-apt stable jdk1.8" | sudo tee /etc/apt/sources.list.d/bazel.list \
    && apt update && apt install -y bazel \
    && rm -rf /var/lib/apt/lists/*

# Common P4 dependencies
RUN apt-get update && apt-get install -y --no-install-recommends \
    automake \
    bison \
    clang \
    cmake \
    flex \
    lcov \
    libboost-dev \
    libboost-filesystem-dev \
    libboost-graph-dev \
    libboost-iostreams-dev \
    libboost-program-options-dev \
    libboost-system-dev \
    libboost-thread-dev \
    libfl-dev \
    libgc-dev \
    libgmp-dev \
    libpcap-dev \
    libreadline-dev \
    libtool \
    pkg-config \
    python-is-python3 \
    python3 \
    python3-pip \
    tcpdump \
    && rm -rf /var/lib/apt/lists/*
RUN pip3 install \
    ipaddr \
    ply \
    pyroute2 \
    scapy \
    "clang-format>=15.0.4"

# Build P4 projects
COPY dev $WORKDIR/dev
WORKDIR $WORKDIR/dev
RUN ./build-pi.sh
RUN ./build-bmv2.sh
RUN ./build-pi-bmv2.sh
RUN ./build-p4c.sh

WORKDIR $WORKDIR
