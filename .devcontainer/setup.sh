#!/bin/bash

# Exit on error, undefined vars, and pipe failures
set -euo pipefail
IFS=$'\n\t'

# Source SSH agent setup
echo "Setting up SSH agent..."
source .devcontainer/ssh-agent-setup.sh

# Configure Git
echo "Configuring Git..."
git config --global core.editor 'nano'
git config --global init.defaultBranch main

# Display container information
echo "Container Information:"
echo "DEVCONTAINER_USER in container: $USER"
whoami
id

# Check SSH agent
echo "Checking SSH agent..."
ssh-add -l

# Check Ansible
echo "Checking Ansible..."
ansible --version

# Setup Python environment
echo "Setting up Python environment..."
python3 -m pip install --user --upgrade pip wheel setuptools
python3 -m pip check

# Install Ansible collections
echo "Installing Ansible collections..."
ansible-galaxy collection list

# Setup pre-commit hooks
echo "Setting up pre-commit hooks..."
pre-commit install --install-hooks
pre-commit install --hook-type commit-msg

echo "Setup complete!"
