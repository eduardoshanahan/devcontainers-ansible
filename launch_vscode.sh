#!/bin/bash

# Load environment variables from .devcontainer/.env
if [ -f .devcontainer/.env ]; then
    export $(grep -v '^#' .devcontainer/.env | xargs)
    grep -v '^#' .devcontainer/.env
fi

# Verify that variables are set
echo $HOST_USERNAME
echo $HOST_UID
echo $HOST_GID
echo $GIT_USER_NAME
echo $GIT_USER_EMAIL
# Launch VS Code
code .
