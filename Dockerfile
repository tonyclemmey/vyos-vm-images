FROM debian:12.6

# Locales
RUN apt-get update && DEBIAN_FRONTEND=noninteractive apt-get install -y locales
RUN sed -i -e 's/# en_US.UTF-8 UTF-8/en_US.UTF-8 UTF-8/' /etc/locale.gen && \
    dpkg-reconfigure --frontend=noninteractive locales && \
    update-locale LANG=en_US.UTF-8
ENV LC_ALL=en_US.UTF-8
ENV LANG=en_US.UTF-8
ENV LANGUAGE=en_US.UTF-8

# Install minimal dependencies
RUN apt-get update && apt-get install -y \
    ansible \
    python3

# Install required packages (from ansible role "install-packages")
RUN apt-get update && apt-get install -y \
    gdisk \
    kpartx \
    dosfstools \
    e2fsprogs \
    gnupg \
    qemu-utils \
    python3-lxml \
    grub-efi-amd64 \
    grub-efi-amd64-bin \
    grub-common \
    isolinux \
    python3-requests \
    rsync \
    unzip \
    zlib1g-dev \
    squashfs-tools \
    xorriso \
    build-essential

# Install not required dependencies
RUN apt-get install -y \
    git \
    mc \
    nano \
    && rm -rf /var/lib/apt/lists/*

# Make build directory
RUN mkdir -p /home/build
WORKDIR /home/build
