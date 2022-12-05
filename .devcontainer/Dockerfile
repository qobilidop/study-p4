FROM p4lang/third-party:latest

ENV WORKDIR /workspaces/play-p4

# Base tools
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

WORKDIR $WORKDIR
