#!/bin/bash
# --- SSH Agent Setup ---

# Exit on error, undefined vars, and pipe failures
set -euo pipefail
IFS=$'\n\t'

# Function to check file permissions
check_file_permissions() {
    local file="$1"
    local expected_perms="$2"
    local actual_perms

    actual_perms=$(stat -c %a "$file")
    if [ "$actual_perms" != "$expected_perms" ]; then
        echo "Warning: $file has incorrect permissions ($actual_perms). Expected: $expected_perms"
        return 1
    fi
    return 0
}

# Check for an interactive shell.
if [[ $- == *i* ]]; then
    # Create .ssh directory with proper permissions if it doesn't exist
    if [ ! -d "$HOME/.ssh" ]; then
        mkdir -p "$HOME/.ssh"
        chmod 700 "$HOME/.ssh"
    else
        check_file_permissions "$HOME/.ssh" "700" || chmod 700 "$HOME/.ssh"
    fi

    # Check if SSH agent is running; if not, attempt to load or start one.
    if [ -z "${SSH_AUTH_SOCK:-}" ]; then
        # Try to load an existing agent environment file.
        if [ -f "$HOME/.ssh/agent_env" ]; then
            if check_file_permissions "$HOME/.ssh/agent_env" "600"; then
                # shellcheck source=/dev/null
                source "$HOME/.ssh/agent_env" >/dev/null
                # Verify the loaded agent actually works
                if ! ssh-add -l &>/dev/null; then
                    echo "Stored agent not working, starting new one..."
                    rm -f "$HOME/.ssh/agent_env"
                    eval "$(ssh-agent -s)" >/dev/null
                fi
            else
                echo "Warning: agent_env file has incorrect permissions. Removing it."
                rm -f "$HOME/.ssh/agent_env"
                eval "$(ssh-agent -s)" >/dev/null
            fi
        else
            echo "Starting new SSH agent..."
            eval "$(ssh-agent -s)" >/dev/null
        fi

        # Save the agent variables with proper permissions
        umask 077
        {
            echo "export SSH_AUTH_SOCK=${SSH_AUTH_SOCK}"
            echo "export SSH_AGENT_PID=${SSH_AGENT_PID}"
        } >"$HOME/.ssh/agent_env"

        # Try to add default keys if they exist
        for key in id_rsa id_ed25519 id_ecdsa; do
            if [ -f "$HOME/.ssh/$key" ]; then
                if check_file_permissions "$HOME/.ssh/$key" "600"; then
                    ssh-add "$HOME/.ssh/$key" 2>/dev/null || echo "Failed to add $key"
                else
                    echo "Warning: $key has incorrect permissions. Skipping."
                fi
            fi
        done
    fi
fi
# --- End SSH Agent Setup ---
