#!/bin/sh
# Shared env loader: load project-root .env (authoritative)
# Usage:
#   # from inside container: source /workspace/.devcontainer/scripts/env-loader.sh && load_project_env /workspace [debug]
#   # from host script: source "$PROJECT_DIR/.devcontainer/scripts/env-loader.sh" && load_project_env "$PROJECT_DIR" [debug]
#
# Debug mode:
#   - Set ENV_LOADER_DEBUG=1 (exported) or pass second param as 1 to load_project_env to print newly loaded vars.

load_project_env() {
    workspace_dir="${1:-/workspace}"
    debug="${2:-${ENV_LOADER_DEBUG:-0}}"
    project_env="$workspace_dir/.env"
    # Capture current variables
    before_file="$(mktemp)"
    env | sort > "$before_file"

    # Load project root .env first (authoritative); preserve quoting
    if [ -f "$project_env" ]; then
        set -a
        # shellcheck disable=SC1090
        . "$project_env"
        set +a
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
