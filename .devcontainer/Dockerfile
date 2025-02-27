# Use Ubuntu 22.04 LTS as the base image
FROM ubuntu:22.04

# Prevent interactive prompts during package installation
ARG DEBIAN_FRONTEND=noninteractive

# Arguments from devcontainer.json
ARG HOST_USERNAME
ARG HOST_UID
ARG HOST_GID
ARG GIT_USER_NAME
ARG GIT_USER_EMAIL

# Set environment variables
ENV PYTHONUNBUFFERED=1 \
    PYTHONDONTWRITEBYTECODE=1 \
    LANG=C.UTF-8 \
    LC_ALL=C.UTF-8

# Install essential packages and clean up in one layer to reduce image size
RUN apt-get update && apt-get install -y --no-install-recommends \
    python3 \
    python3-pip \
    build-essential \
    python3-cairo \
    git \
    openssh-client \
    curl \
    wget \
    gnupg \
    lsb-release \
    software-properties-common \
    sudo \
    less \
    && rm -rf /var/lib/apt/lists/*

# Install Ansible and related tools
RUN pip3 install --no-cache-dir \
    ansible==8.5.0 \
    ansible-lint==6.22.1 \
    yamllint==1.33.0 \
    molecule==6.0.2 \
    docker==7.0.0 \
    pytest==8.0.0 \
    pytest-testinfra==9.0.0

# Create non-root user with sudo access
RUN groupadd --gid $HOST_GID $HOST_USERNAME \
    && useradd --uid $HOST_UID --gid $HOST_GID -m $HOST_USERNAME \
    && echo $HOST_USERNAME ALL=\(root\) NOPASSWD:ALL > /etc/sudoers.d/$HOST_USERNAME \
    && chmod 0440 /etc/sudoers.d/$HOST_USERNAME

# Configure Git for the user
USER $HOST_USERNAME
RUN git config --global user.name "$GIT_USER_NAME" \
    && git config --global user.email "$GIT_USER_EMAIL" \
    && git config --global init.defaultBranch main \
    && git config --global pull.rebase false

# Set up Python environment for the user
RUN python3 -m pip install --user --no-cache-dir \
    pylint==3.0.3 \
    flake8==7.0.0 \
    black==24.1.1 \
    mypy==1.8.0 \
    pre-commit==3.6.2 \
    commitizen==3.15.0 \
    gitlint==0.19.1 \
    git-changelog==2.3.2

# Create workspace directory and set permissions
USER root
RUN mkdir -p /workspace \
    && chown $HOST_USERNAME:$HOST_USERNAME /workspace

# Switch back to non-root user
USER $HOST_USERNAME
WORKDIR /workspace

# Add local bin to PATH
ENV PATH="/home/$HOST_USERNAME/.local/bin:${PATH}"
