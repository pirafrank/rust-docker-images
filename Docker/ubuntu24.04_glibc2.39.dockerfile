FROM ubuntu:24.04

# Ubuntu 24.04 Noble features glibc version 2.39.

ARG USER_UID=1000
ARG RUST_VERSION="1.87.0"

RUN apt-get update && \
  DEBIAN_FRONTEND=noninteractive apt-get install -y \
    curl \
    gcc \
    g++ \
    pkg-config \
    ca-certificates \
    git \
    libssl-dev \
    make \
    tzdata \
    tar \
    gzip \
    bzip2 \
    sudo \
    locales \
    && apt-get clean

RUN echo 'add user and change default shell' \
  && useradd -m -d /home/work -s /bin/bash --uid $USER_UID work \
  && echo work ALL=\(root\) NOPASSWD:ALL > /etc/sudoers.d/work \
  && chmod 0440 /etc/sudoers.d/work \
  && echo "root:root" | chpasswd \
  && echo "work:work" | chpasswd

ENV LANG="en_US.UTF-8" LC_ALL="C" LANGUAGE="en_US.UTF-8"
ENV TZ=Europe/Rome

USER work
WORKDIR /home/work

# Install Rust
RUN curl --proto '=https' --tlsv1.2 -sSf https://sh.rustup.rs | bash -s -- --default-toolchain $RUST_VERSION -y
ENV PATH="/home/work/.cargo/bin:${PATH}"

# Add a default workdir
WORKDIR /home/work/project
