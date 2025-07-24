# Use the official Ubuntu 22.04 image as a base
FROM ubuntu:22.04

# Set locale
ENV LC_ALL=C.UTF-8
ENV LANG=C.UTF-8

# Install basic dependencies
RUN apt-get update && apt-get install -y \
    curl \
    git \
    build-essential \
    openssh-client \
    jq \
    python3 \
    python3-pip \
    && rm -rf /var/lib/apt/lists/*

# Install Starship
RUN curl -sS https://starship.rs/install.sh | sh -s -- --yes

# Set the working directory
WORKDIR /workspace

ARG USERNAME
ARG USER_UID
ARG USER_GID

# Create the user
RUN groupadd --gid $USER_GID $USERNAME \
    && useradd --uid $USER_UID --gid $USER_GID -m $USERNAME \
    && apt-get update \
    && apt-get install -y sudo \
    && echo $USERNAME ALL=\(root\) NOPASSWD:ALL > /etc/sudoers.d/$USERNAME \
    && chmod 0440 /etc/sudoers.d/$USERNAME

# Ensure bash is the default shell for the user
RUN chsh -s /bin/bash $USERNAME

# Set ownership of workspace
RUN chown $USERNAME:$USERNAME /workspace

# Install Ansible and related tools
RUN pip3 install --no-cache-dir \
    ansible \
    ansible-lint \
    yamllint \
    jmespath

# Create ansible config directory and set permissions
RUN mkdir -p /etc/ansible && \
    chown -R $USERNAME:$USERNAME /etc/ansible