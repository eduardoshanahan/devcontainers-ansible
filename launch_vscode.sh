#!/bin/bash

# Exit on error, undefined vars, and pipe failures
set -euo pipefail
IFS=$'\n\t'

# Function to check required environment variables
check_required_vars() {
    local missing=0
    local required_vars=(
        "HOST_USERNAME"
        "HOST_UID"
        "HOST_GID"
        "GIT_USER_NAME"
        "GIT_USER_EMAIL"
    )

    for var in "${required_vars[@]}"; do
        if [ -z "${!var:-}" ]; then
            echo "Error: $var is not set"
            missing=1
        fi
    done

    if [ $missing -eq 1 ]; then
        echo "Please set all required environment variables in .devcontainer/.env"
        exit 1
    fi
}

# Function to check if VS Code is installed
check_vscode() {
    if ! command -v code >/dev/null 2>&1; then
        echo "Error: VS Code is not installed or not in PATH"
        echo "Please install VS Code: https://code.visualstudio.com/"
        exit 1
    fi
}

# Function to check required files
check_required_files() {
    local missing=0
    local required_files=(
        ".devcontainer/devcontainer.json"
        ".devcontainer/Dockerfile"
        ".devcontainer/ssh-agent-setup.sh"
    )

    for file in "${required_files[@]}"; do
        if [ ! -f "$file" ]; then
            echo "Error: Required file $file is missing"
            missing=1
        fi
    done

    if [ $missing -eq 1 ]; then
        echo "Please ensure all required files are present"
        exit 1
    fi
}

# Main execution
echo "Checking requirements..."
check_vscode
check_required_files

# Load environment variables from .devcontainer/.env
if [ -f .devcontainer/.env ]; then
    # Load while ignoring comments and empty lines
    set -a
    source <(grep -v '^#' .devcontainer/.env | grep .)
    set +a
    echo "Environment variables loaded from .devcontainer/.env"
else
    echo "Warning: .devcontainer/.env file not found"
fi

# Check required environment variables
check_required_vars

# Source the SSH agent setup script
if [ -f ".devcontainer/ssh-agent-setup.sh" ]; then
    source ".devcontainer/ssh-agent-setup.sh"
    echo "SSH agent setup completed"
else
    echo "Error: SSH agent setup script not found"
    exit 1
fi

# Display environment information
echo "Environment Configuration:"
echo "------------------------"
echo "User: $HOST_USERNAME (UID: $HOST_UID, GID: $HOST_GID)"
echo "Git: $GIT_USER_NAME <$GIT_USER_EMAIL>"
echo "------------------------"
echo "SSH Keys:"
ssh-add -l || echo "No SSH keys loaded"
echo "------------------------"

# Launch VS Code
echo "Launching VS Code..."
code . || {
    echo "Error: Failed to launch VS Code"
    exit 1
}
