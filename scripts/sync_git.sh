#!/bin/bash

# Enable strict mode
set -euo pipefail

# Colors for output
RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
NC='\033[0m' # No Color

# Print functions
info() { echo -e "${YELLOW}ℹ️  $1${NC}"; }
success() { echo -e "${GREEN}✅ $1${NC}"; }
error() { echo -e "${RED}❌ $1${NC}" >&2; }

# Get the actual project directory (parent of scripts directory)
SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
PROJECT_DIR="$(dirname "$SCRIPT_DIR")"

# Configuration with defaults
BRANCH="${BRANCH:-main}"
FORCE_PULL="${FORCE_PULL:-false}"

# Function to backup local changes
backup_local_changes() {
    local backup_dir="$PROJECT_DIR/backup_$(date +%Y%m%d_%H%M%S)"
    info "Creating backup in $backup_dir..."
    mkdir -p "$backup_dir"
    git diff > "$backup_dir/local_changes.patch"
    git status --porcelain | while read -r status file; do
        if [[ $status == "??" ]]; then
            cp --parents "$file" "$backup_dir/"
        fi
    done
    success "Backup created in $backup_dir"
}

# Main script
main() {
    cd "$PROJECT_DIR" || { error "Project directory not found!"; exit 1; }
    info "Working in directory: $PROJECT_DIR"

    # Check if .git exists
    if [ ! -d ".git" ]; then
        info "No .git folder found. Initializing git repository..."
        git init

        # Check if remote URL is configured
        if ! git remote get-url origin &>/dev/null; then
            info "No remote configured. Please run:"
            echo "git remote add origin <your-repository-url>"
            echo "git fetch origin"
            echo "git checkout -t origin/$BRANCH"
            exit 0
        fi
    fi

    # Get current remote URL
    REMOTE_URL=$(git remote get-url origin 2>/dev/null || echo "")

    if [ -z "$REMOTE_URL" ]; then
        error "No remote URL configured. Please set up your git remote first."
        exit 1
    fi

    success "Git repository found with remote: $REMOTE_URL"

    # Check if we're in detached HEAD state
    if ! git symbolic-ref HEAD &>/dev/null; then
        info "Detached HEAD state detected. Checking out $BRANCH..."
        git checkout "$BRANCH" || git checkout -b "$BRANCH"
    fi

    info "Syncing with remote repository..."

    if [ "$FORCE_PULL" = true ]; then
        info "Force pulling and overwriting local changes..."
        backup_local_changes
        git fetch origin
        git reset --hard "origin/$BRANCH"
        git clean -fd  # Remove untracked files and directories
    else
        # Check for local changes
        if ! git diff-index --quiet HEAD --; then
            error "Local changes detected. Please commit or stash them first."
            error "Or set FORCE_PULL=true to overwrite local changes."
            exit 1
        fi
        git pull origin "$BRANCH"
    fi

    success "Git sync complete!"
}

# Run main function
main "$@"
