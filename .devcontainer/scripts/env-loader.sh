#!/bin/sh
# Shared env loader: load project-root .env (authoritative)
# Usage:
#   # from inside container: source /workspace/.devcontainer/scripts/env-loader.sh && load_project_env /workspace [debug]
#   # from host script: source "$PROJECT_DIR/.devcontainer/scripts/env-loader.sh" && load_project_env "$PROJECT_DIR" [debug]
#
# Debug mode:
#   - Set ENV_LOADER_DEBUG=1 (exported) or pass second param as 1 to load_project_env to print newly loaded vars.

load_project_env() {
    workspace_dir="${1:-${WORKSPACE_FOLDER:-}}"
    debug="${2:-${ENV_LOADER_DEBUG:-0}}"
    if [ -z "$workspace_dir" ]; then
        printf 'env-loader: workspace directory not provided; pass as arg or set WORKSPACE_FOLDER\n' >&2
        return 1
    fi
    project_env="$workspace_dir/.env"
    if [ ! -f "$project_env" ]; then
        printf 'env-loader: required .env not found at %s\n' "$project_env" >&2
        return 1
    fi
    # Preserve a valid SSH_AUTH_SOCK from the caller (e.g., /ssh-agent in container).
    original_ssh_auth_sock="${SSH_AUTH_SOCK:-}"
    original_ssh_auth_sock_valid=false
    if [ -n "$original_ssh_auth_sock" ] && [ -S "$original_ssh_auth_sock" ]; then
        original_ssh_auth_sock_valid=true
    fi
    # Capture current variables
    before_file="$(mktemp)"
    env | sort > "$before_file"

    # Load project root .env first (authoritative); preserve quoting
    set -a
    # shellcheck disable=SC1090
    . "$project_env"
    set +a

    if [ "$original_ssh_auth_sock_valid" = true ]; then
        export SSH_AUTH_SOCK="$original_ssh_auth_sock"
    fi

    # Capture after state and compute newly added variables
    after_file="$(mktemp)"
    env | sort > "$after_file"

    if [ "$debug" = "1" ] || [ "$debug" = "true" ]; then
        echo "env-loader: debug enabled - listing variables added by load_project_env (workspace: $workspace_dir)"
        # comm -13 shows lines present in after_file but not before_file
        if command -v comm >/dev/null 2>&1; then
            comm -13 "$before_file" "$after_file"
        else
            # Fallback: simple grep/diff approach
            echo "env-loader: comm not available; showing all variables (best-effort)"
            cat "$after_file"
        fi
    fi

    # Clean up
    rm -f "$before_file" "$after_file" 2>/dev/null || true
}
