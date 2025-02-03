#!/bin/bash
# --- SSH Agent Setup ---

# Check for an interactive shell.
if [[ $- == *i* ]]; then
    # Check if SSH agent is running; if not, attempt to load or start one.
    if [ -z "$SSH_AUTH_SOCK" ]; then
        # Try to load an existing agent environment file.
        if [ -f "$HOME/.ssh/agent_env" ]; then
            source "$HOME/.ssh/agent_env"
        fi

        # If still not running, start a new agent.
        if [ -z "$SSH_AUTH_SOCK" ]; then
            echo "Starting new SSH agent..."
            eval "$(ssh-agent -s)" > /dev/null
            # Save the agent variables for future shells.
            echo "export SSH_AUTH_SOCK=${SSH_AUTH_SOCK}" > "$HOME/.ssh/agent_env"
            echo "export SSH_AGENT_PID=${SSH_AGENT_PID}" >> "$HOME/.ssh/agent_env"
        fi
    fi

    # Check that SSH_KEY variable is set
    if [ -z "$SSH_KEY" ]; then
        echo "SSH_KEY variable is not set. Please set it in your .env file."
    else
        # Optionally, add your key if it isn’t already loaded.
        if ! ssh-add -l 2>/dev/null | grep -q "$SSH_KEY"; then
            if [ -f "$HOME/.ssh/$SSH_KEY" ]; then
                echo "Adding SSH key: $SSH_KEY"
                ssh-add "$HOME/.ssh/$SSH_KEY" >/dev/null 2>&1
            else
                echo "SSH key $HOME/.ssh/$SSH_KEY not found."
            fi
        fi
    fi
fi
# --- End SSH Agent Setup ---
