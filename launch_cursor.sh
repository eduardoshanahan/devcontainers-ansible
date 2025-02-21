#!/bin/bash

# Exit on error, undefined vars, and pipe failures
set -euo pipefail
IFS=$'\n\t'

# Set default values for environment variables
export HOST_USERNAME="${USER}"
export HOST_UID="$(id -u)"
export HOST_GID="$(id -g)"
export GIT_USER_NAME="$(git config --get user.name || echo '')"
export GIT_USER_EMAIL="$(git config --get user.email || echo '')"

# Check if VS Code is installed
if ! command -v cursor >/dev/null 2>&1; then
    echo "Error: VS Code is not installed"
    echo "Please install VS Code: https://code.visualstudio.com/"
    exit 1
fi

# Check if Docker is running
if ! docker info >/dev/null 2>&1; then
    echo "Error: Docker is not running"
    echo "Please start Docker and try again"
    exit 1
fi

# Check Git configuration
if [ -z "$GIT_USER_NAME" ] || [ -z "$GIT_USER_EMAIL" ]; then
    echo "Warning: Git user.name or user.email not configured"
    echo "Please configure Git:"
    echo "  git config --global user.name \"Your Name\""
    echo "  git config --global user.email \"your.email@example.com\""
    exit 1
fi

# Launch VS Code
echo "Launching VS Code..."
echo "User: $HOST_USERNAME (UID: $HOST_UID, GID: $HOST_GID)"
echo "Git: $GIT_USER_NAME <$GIT_USER_EMAIL>"

cursor . --no-sandbox || {
    echo "Error: Failed to launch VS Code"
    exit 1
}
