# https://github.com/p4lang/third-party/blob/main/Dockerfile
FROM p4lang/third-party:latest

ENV WORKDIR /workspaces/study-p4

# Set locale
# https://stackoverflow.com/q/28405902
RUN apt-get update && apt-get install -y locales && \
    sed -i -e 's/# en_US.UTF-8 UTF-8/en_US.UTF-8 UTF-8/' /etc/locale.gen && \
    locale-gen
ENV LANG=en_US.UTF-8  
ENV LANGUAGE=en_US:en  
ENV LC_ALL=en_US.UTF-8

# Install basic tools
ARG DEBIAN_FRONTEND=noninteractive
RUN apt-get update && apt-get install -y \
    build-essential \
    git \
    python-is-python3 \
    python3 \
    python3-pip \
    sudo \
    && rm -rf /var/lib/apt/lists/*

# Start building P4 projects
WORKDIR $WORKDIR/env

# Build PI
# https://github.com/p4lang/PI/blob/main/Dockerfile
RUN apt-get update && apt-get install -y --no-install-recommends \
    automake \
    build-essential \
    g++ \
    libboost-dev \
    libboost-system-dev \
    libboost-thread-dev \
    libtool \
    pkg-config \
    && rm -rf /var/lib/apt/lists/*
COPY env/PI $WORKDIR/env/PI
COPY env/build-pi.sh $WORKDIR/env/build-pi.sh
RUN ./build-pi.sh

# Build bmv2
# https://github.com/p4lang/behavioral-model/blob/main/Dockerfile
RUN apt-get update && apt-get install -y --no-install-recommends \
    automake \
    build-essential \
    clang \
    curl \
    git \
    lcov \
    libboost-dev \
    libboost-filesystem-dev \
    libboost-program-options-dev \
    libboost-system-dev \
    libboost-thread-dev \
    libgmp-dev \
    libpcap-dev \
    libtool \
    pkg-config \
    && rm -rf /var/lib/apt/lists/*
COPY env/behavioral-model $WORKDIR/env/behavioral-model
COPY env/build-bmv2.sh $WORKDIR/env/build-bmv2.sh
RUN ./build-bmv2.sh

# Build p4c
# https://github.com/p4lang/p4c#ubuntu-dependencies
RUN apt-get update && apt-get install -y --no-install-recommends \
    automake \
    bison \
    cmake \
    flex \
    g++ \
    git \
    libboost-dev \
    libboost-graph-dev \
    libboost-iostreams-dev \
    libfl-dev \
    libgc-dev \
    libtool \
    llvm \
    pkg-config \
    python3 \
    python3-pip \
    tcpdump \
    && rm -rf /var/lib/apt/lists/*
RUN pip install \
    clang-format \
    ipaddr \
    ply \
    scapy
COPY env/p4c $WORKDIR/env/p4c
COPY env/build-p4c.sh $WORKDIR/env/build-p4c.sh
RUN ./build-p4c.sh

# Build p4-dpdk-target
ENV SDE /home/sde
ENV SDE_INSTALL $SDE/install
# https://github.com/p4lang/p4-dpdk-target#install-dependent-packages
# https://github.com/p4lang/p4-dpdk-target/blob/main/tools/setup/install_dep.py
RUN apt-get update && apt-get install -y --no-install-recommends \
    autoconf \
    autoconf-archive \
    autotools-dev \
    clang \
    cmake \
    connect-proxy \
    curl \
    gcc \
    git \
    google-perftools \
    libconfig-dev \
    libedit-dev \
    libexpat1-dev \
    libffi-dev \
    libtool \
    libunwind-dev \
    meson \
    ninja-build \
    patch \
    python3 \
    python3-cffi \
    python3-pip \
    python3-setuptools \
    python3-wheel \
    tshark \
    unifdef \
    zlib1g-dev\
    && rm -rf /var/lib/apt/lists/*
RUN pip install \
    distro \
    protobuf \
    pyelftools \
    scapy \
    six \
    thrift
COPY env/p4-dpdk-target $WORKDIR/env/p4-dpdk-target
COPY env/build-p4-dpdk-target.sh $WORKDIR/env/build-p4-dpdk-target.sh
RUN ./build-p4-dpdk-target.sh

# Install misc tools
RUN apt-get update && apt-get install -y \
    graphviz \
    && rm -rf /var/lib/apt/lists/*

# Ready to go

WORKDIR $WORKDIR
