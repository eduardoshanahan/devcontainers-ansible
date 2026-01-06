#!/usr/bin/env bash
# Shared env loader: load project-root .env (authoritative)
# Usage:
#   # from inside container: source /workspace/.devcontainer/scripts/env-loader.sh && load_project_env /workspace [debug]
#   # from host script: source "$PROJECT_DIR/.devcontainer/scripts/env-loader.sh" && load_project_env "$PROJECT_DIR" [debug]
#
# Debug mode:
#   - Set ENV_LOADER_DEBUG=1 (exported) or pass second param as 1 to load_project_env to print newly loaded vars.

load_project_env() {
    local workspace_dir="${1:-/workspace}"
    local debug="${2:-${ENV_LOADER_DEBUG:-0}}"
    local project_env="$workspace_dir/.env"
    # Capture current variables
    local before_file
    before_file="$(mktemp)"
    compgen -v | sort > "$before_file"

    # Load project root .env first (authoritative); preserve quoting
    if [ -f "$project_env" ]; then
        set -a
        # shellcheck disable=SC1090
        source "$project_env"
        set +a
    fi

    # Capture after state and compute newly added variables
    local after_file
    after_file="$(mktemp)"
    compgen -v | sort > "$after_file"

    if [ "$debug" = "1" ] || [ "$debug" = "true" ]; then
        echo "env-loader: debug enabled — listing variables added by load_project_env (workspace: $workspace_dir)"
        # comm -13 shows lines present in after_file but not before_file
        if command -v comm >/dev/null 2>&1; then
            while IFS= read -r var; do
                # Skip empty var names (defensive)
                [ -z "$var" ] && continue
                # Print name and value
                printf '%s=%s\n' "$var" "${!var:-}"
            done < <(comm -13 "$before_file" "$after_file")
        else
            # Fallback: simple grep/diff approach
            echo "env-loader: comm not available; showing all variables (best-effort)"
            while IFS= read -r var; do
                [ -z "$var" ] && continue
                printf '%s=%s\n' "$var" "${!var:-}"
            done < "$after_file"
        fi
    fi

    # Clean up
    rm -f "$before_file" "$after_file" 2>/dev/null || true
}
