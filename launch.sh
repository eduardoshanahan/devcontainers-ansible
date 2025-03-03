#!/bin/bash
# shellcheck source=.devcontainer/.env

# Set strict bash options
set -euo pipefail

# Colors for output
RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
NC='\033[0m' # No Color

# Function to print error messages
error() {
  echo -e "${RED}ERROR: $1${NC}" >&2
}

# Function to print success messages
success() {
  echo -e "${GREEN}$1${NC}"
}

# Function to print info messages
info() {
  echo -e "${YELLOW}$1${NC}"
}

# Function to check if a variable is set
check_var() {
  local var_name="$1"
  local var_value="$2"
  if [ -z "$var_value" ]; then
    error "$var_name is not set in .devcontainer/.env"
    return 1
  fi
  info "$var_name: $var_value"
}

# Function to verify SSH agent forwarding
verify_ssh_agent() {
  info "Verifying SSH agent forwarding..."

  if [ -z "$SSH_AUTH_SOCK" ]; then
    error "SSH_AUTH_SOCK is not set on host machine"
    info "Please ensure your SSH agent is running: eval \"\$(ssh-agent -s)\""
    return 1
  fi

  # Start SSH agent if not running
  if ! ssh-add -l >/dev/null 2>&1; then
    info "Starting SSH agent..."
    eval "$(ssh-agent -s)"
  fi

  # Add any available SSH keys
  info "Adding available SSH keys..."
  for key in ~/.ssh/id_*; do
    if [[ -f "$key" && "$key" != *.pub ]]; then
      if ! ssh-add -l | grep -q "$(ssh-keygen -lf "$key" | awk '{print $2}')" >/dev/null 2>&1; then
        if ssh-add "$key" 2>/dev/null; then
          info "Added key: $key"
        else
          error "Failed to add key: $key"
        fi
      else
        info "Key already added: $key"
      fi
    fi
  done

  # Test if SSH agent is accessible
  if ! ssh-add -l >/dev/null 2>&1; then
    error "No SSH keys found in agent"
    info "Please ensure you have SSH keys in ~/.ssh/"
    return 1
  fi

  # Test GitHub SSH connection specifically
  info "Testing GitHub SSH connection..."
  ssh_output=$(ssh -T git@github.com 2>&1)
  info "GitHub SSH response: $ssh_output"
  if ! echo "$ssh_output" | grep -q "successfully authenticated"; then
    error "GitHub SSH authentication failed"
    info "Please ensure your GitHub SSH key is added to your SSH agent"
    return 1
  fi

  success "SSH agent forwarding configured"
}

# Check if .env file exists
if [ ! -f .devcontainer/.env ]; then
  error ".devcontainer/.env file not found!"
  error "Please create it with the following variables:"
  cat <<EOF
# User configuration
HOST_USERNAME=your_username
HOST_UID=your_uid
HOST_GID=your_gid

# Git configuration
GIT_USER_NAME="Your Name"
GIT_USER_EMAIL="your.email@example.com"

# Editor configuration
EDITOR_CHOICE=code  # Use 'code' for VS Code or 'cursor' for Cursor

# Docker configuration
DOCKER_IMAGE_NAME=your-image-name
DOCKER_IMAGE_TAG=your-tag
EOF
  exit 1
fi

# Load environment variables from .devcontainer/.env
info "Loading environment variables..."
set -a
source .devcontainer/.env
set +a

# Verify required variables
required_vars=(
  "HOST_USERNAME"
  "HOST_UID"
  "HOST_GID"
  "GIT_USER_NAME"
  "GIT_USER_EMAIL"
  "EDITOR_CHOICE"
  "DOCKER_IMAGE_NAME"
  "DOCKER_IMAGE_TAG"
)

# Check all required variables
for var in "${required_vars[@]}"; do
  check_var "$var" "${!var:-}" || exit 1
done

# Validate editor choice
if [ "${EDITOR_CHOICE}" != "code" ] && [ "${EDITOR_CHOICE}" != "cursor" ]; then
  error "EDITOR_CHOICE must be set to either 'code' or 'cursor' in .devcontainer/.env"
  exit 1
fi

# Check if the chosen editor is installed
if ! command -v "${EDITOR_CHOICE}" &>/dev/null; then
  error "${EDITOR_CHOICE} is not installed!"
  if [ "${EDITOR_CHOICE}" = "code" ]; then
    error "Please install VS Code from https://code.visualstudio.com/"
  else
    error "Please install Cursor from https://cursor.sh"
  fi
  exit 1
fi

# Verify SSH agent forwarding
verify_ssh_agent || exit 1

# Clean up any existing containers using our image
if docker ps -a | grep -q "${DOCKER_IMAGE_NAME}"; then
  info "Cleaning up existing containers..."
  docker ps -a | grep "${DOCKER_IMAGE_NAME}" | cut -d' ' -f1 | xargs -r docker stop
  docker ps -a | grep "${DOCKER_IMAGE_NAME}" | cut -d' ' -f1 | xargs -r docker rm
fi

# Launch the editor
info "Launching ${EDITOR_CHOICE}..."
if [ "${EDITOR_CHOICE}" = "code" ]; then
  code "${PWD}" >/dev/null 2>&1 &
else
  cursor "${PWD}" --no-sandbox >/dev/null 2>&1 &
fi

success "${EDITOR_CHOICE} launched successfully!"
disown
