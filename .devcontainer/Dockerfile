# Use Ubuntu 22.04 LTS as the base image
FROM ubuntu:22.04

# Add labels for better container management
LABEL maintainer="Eduardo Shanahan"
LABEL description="Development container for Ansible and Git in Ubuntu"

# Prevent interactive prompts during package installation
ARG DEBIAN_FRONTEND=noninteractive

# Set timezone
ENV TZ=Europe/Dublin
RUN ln -snf /usr/share/zoneinfo/$TZ /etc/localtime && echo $TZ > /etc/timezone

# Arguments from devcontainer.json
ARG HOST_USERNAME=vscode
ARG HOST_UID=1000
ARG HOST_GID=1000
ARG GIT_USER_NAME
ARG GIT_USER_EMAIL
ARG EDITOR_CHOICE=code

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
    nano \
    zip \
    unzip \
    tree \
    htop \
    jq \
    bash-completion \
    ca-certificates \
    locales \
    && rm -rf /var/lib/apt/lists/* \
    && wget -O /usr/local/bin/shfmt https://github.com/mvdan/sh/releases/download/v3.0.1/shfmt_v3.0.1_linux_amd64 \
    && chmod +x /usr/local/bin/shfmt

# Set the locale
RUN locale-gen en_IE.UTF-8
ENV LANG=en_IE.UTF-8
ENV LANGUAGE=en_IE:en
ENV LC_ALL=en_IE.UTF-8

# Install Ansible and related tools
RUN pip3 install --no-cache-dir \
    ansible==9.2.0 \
    ansible-lint==25.1.3 \
    yamllint==1.34.0 \
    molecule==6.0.2 \
    docker==7.0.0 \
    pytest==8.0.0 \
    pytest-testinfra==9.0.0

# Create non-root user with sudo access
RUN groupadd --gid ${HOST_GID} ${HOST_USERNAME} \
    && useradd --uid ${HOST_UID} --gid ${HOST_GID} -m ${HOST_USERNAME} \
    && echo ${HOST_USERNAME} ALL=\(root\) NOPASSWD:ALL > /etc/sudoers.d/${HOST_USERNAME} \
    && chmod 0440 /etc/sudoers.d/${HOST_USERNAME}

# Configure Git for the user
USER $HOST_USERNAME
RUN if [ "$EDITOR_CHOICE" = "cursor" ]; then \
    git config --global core.editor "cursor --wait"; \
    else \
    git config --global core.editor "code --wait"; \
    fi && \
    git config --global user.name "${GIT_USER_NAME}" && \
    git config --global user.email "${GIT_USER_EMAIL}" && \
    git config --global init.defaultBranch main && \
    git config --global core.autocrlf input && \
    git config --global pull.rebase false && \
    git config --global color.ui auto && \
    git config --global core.fileMode true && \
    git config --global help.autocorrect 1

# Set up Python environment for the user
USER $HOST_USERNAME
RUN mkdir -p /home/$HOST_USERNAME/.local/bin && \
    /usr/bin/python3 -m pip install --user --no-cache-dir \
    pylint==3.0.3 \
    flake8==7.0.0 \
    black==24.3.0 \
    mypy==1.8.0 \
    pre-commit==3.6.2 \
    commitizen==3.15.0 \
    gitlint==0.19.1 \
    git-changelog==2.3.2 \
    mdformat==0.7.17 \
    mdformat-gfm==0.3.5 \
    mdformat-frontmatter==2.0.1 \
    mdformat-footnote==0.1.1 \
    mdformat-tables==0.4.1 \
    mdformat-toc==0.3.0 \
    mdformat-beautysh==0.1.1

# Setup bash configuration with Git aliases
RUN echo 'export PATH="$HOME/.local/bin:$PATH"' >> ~/.bashrc && \
    echo 'export PS1="\[\033[01;32m\]\u@devcontainer\[\033[00m\]:\[\033[01;34m\]\w\[\033[00m\]\$ "' >> ~/.bashrc && \
    echo 'export HISTSIZE=5000' >> ~/.bashrc && \
    echo 'export HISTFILESIZE=10000' >> ~/.bashrc && \
    echo 'export HISTCONTROL=ignoreboth' >> ~/.bashrc && \
    echo 'export HISTTIMEFORMAT="%F %T "' >> ~/.bashrc && \
    echo 'alias ll="ls -la"' >> ~/.bashrc && \
    echo 'alias ls="ls --color=auto"' >> ~/.bashrc && \
    echo 'alias grep="grep --color=auto"' >> ~/.bashrc && \
    echo 'alias gs="git status"' >> ~/.bashrc && \
    echo 'alias gp="git pull"' >> ~/.bashrc && \
    echo 'alias gd="git diff"' >> ~/.bashrc && \
    echo 'alias gc="git commit"' >> ~/.bashrc && \
    echo 'alias gb="git branch"' >> ~/.bashrc && \
    echo 'alias gl="git log --oneline --graph --decorate"' >> ~/.bashrc && \
    echo 'alias gco="git checkout"' >> ~/.bashrc && \
    echo 'alias gf="git fetch --all --prune"' >> ~/.bashrc && \
    echo 'alias gst="git stash"' >> ~/.bashrc && \
    echo 'alias gstp="git stash pop"' >> ~/.bashrc && \
    echo 'source /etc/bash_completion' >> ~/.bashrc

# Create workspace directory and set permissions
USER root
RUN mkdir -p /workspace \
    && chown $HOST_USERNAME:$HOST_USERNAME /workspace

# Switch back to non-root user
USER $HOST_USERNAME
WORKDIR /workspace

# Add local bin to PATH
ENV PATH="/home/$HOST_USERNAME/.local/bin:${PATH}"
