#!/bin/bash
set -euo pipefail

# Determine project directory (defaults to current working directory)
PROJECT_DIR="${PROJECT_DIR:-$(pwd)}"
ENV_LOADER="$PROJECT_DIR/.devcontainer/scripts/env-loader.sh"

if [ ! -f "$ENV_LOADER" ]; then
    echo "Error: env-loader.sh not found at $ENV_LOADER"
    exit 1
fi

# Load variables: project root .env is authoritative, .devcontainer/config/.env supplies defaults
# shellcheck disable=SC1090
source "$ENV_LOADER"
load_project_env "$PROJECT_DIR"

# Set defaults for container resource limits if not defined
export CONTAINER_MEMORY="${CONTAINER_MEMORY:-4g}"
export CONTAINER_CPUS="${CONTAINER_CPUS:-2}"
export CONTAINER_SHM_SIZE="${CONTAINER_SHM_SIZE:-2g}"

# Set defaults for other variables if not defined
export CONTAINER_HOSTNAME="${CONTAINER_HOSTNAME:-devcontainers-git}"
export PYTHON_VERSION="${PYTHON_VERSION:-3.11}"
export ANSIBLE_VERSION="${ANSIBLE_VERSION:-9.2.0}"
export ANSIBLE_LINT_VERSION="${ANSIBLE_LINT_VERSION:-25.1.3}"

echo "Container configuration:"
echo "  Memory: $CONTAINER_MEMORY"
echo "  CPUs: $CONTAINER_CPUS"
echo "  Shared Memory: $CONTAINER_SHM_SIZE"
echo "  Hostname: $CONTAINER_HOSTNAME"
echo "  Python: $PYTHON_VERSION"
echo "  Ansible: $ANSIBLE_VERSION"
echo "  Ansible Lint: $ANSIBLE_LINT_VERSION"
