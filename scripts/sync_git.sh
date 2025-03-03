#!/bin/bash

# Configuration
PROJECT_DIR=/workspace
REMOTE_URL="git@github.com:eduardoshanahan/devcontainers-ansible.git"
BRANCH="main"
FORCE_PULL=false  # Set to true to force overwrite local changes

cd "$PROJECT_DIR" || { echo "Project directory not found!"; exit 1; }

# Check if .git exists
if [ ! -d ".git" ]; then
    echo "No .git folder found. Initializing git and setting remote..."
    git init
    git remote add origin "$REMOTE_URL"
    git fetch origin
    git checkout -t "origin/$BRANCH"
else
    echo "✅ .git found. Making sure remote is correct..."

    CURRENT_REMOTE=$(git remote get-url origin)
    if [ "$CURRENT_REMOTE" != "$REMOTE_URL" ]; then
        echo "🔄 Updating remote origin URL..."
        git remote set-url origin "$REMOTE_URL"
    fi

    # Check if we're in detached HEAD state
    if ! git symbolic-ref HEAD >/dev/null 2>&1; then
        echo "⚠️  Detached HEAD state detected. Checking out $BRANCH..."
        git checkout "$BRANCH" || git checkout -b "$BRANCH"
    fi

    echo "🔄 Pulling latest changes from $BRANCH..."
    if [ "$FORCE_PULL" = true ]; then
        echo "⚠️  Force pulling and overwriting local changes..."
        # Backup local changes before force pull
        backup_local_changes
        git fetch origin
        git reset --hard "origin/$BRANCH"
        git clean -fd  # Remove untracked files and directories
    else
        git pull origin "$BRANCH"
    fi
fi

# Backup function
backup_local_changes() {
    local backup_dir="backup_$(date +%Y%m%d_%H%M%S)"
    echo "📦 Creating backup in $backup_dir..."
    mkdir -p "$backup_dir"
    git diff >"$backup_dir/local_changes.patch"
    git status --porcelain | while read -r status file; do
        if [[ $status == "??" ]]; then
            cp --parents "$file" "$backup_dir/"
        fi
    done
}

echo "🎉 Git setup and sync complete."
