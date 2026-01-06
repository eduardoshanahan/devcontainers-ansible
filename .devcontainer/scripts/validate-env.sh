#!/bin/sh
set -eu

validate_var() {
    var_name=$1
    var_value=$2
    pattern=$3
    description=$4

    if ! printf '%s' "$var_value" | grep -Eq "$pattern"; then
        echo "Error: $var_name is invalid"
        echo "Description: $description"
        echo "Pattern: $pattern"
        echo "Current value: $var_value"
        return 1
    fi
    return 0
}

errors=0
echo "Validating required variables..."
while IFS='|' read -r var description pattern; do
    [ -z "$var" ] && continue
    eval "value=\${$var:-}"
    if [ -z "$value" ]; then
        echo "Error: Required variable $var is not set"
        echo "Description: $description"
        errors=$((errors + 1))
    else
        if ! validate_var "$var" "$value" "$pattern" "$description"; then
            errors=$((errors + 1))
        fi
    fi
done <<'EOF'
PROJECT_NAME|Project name|^[a-z0-9][a-z0-9-]*$
HOST_USERNAME|System username|^[a-z_][a-z0-9_-]*$
HOST_UID|User ID|^[0-9]+$
HOST_GID|Group ID|^[0-9]+$
CONTAINER_HOSTNAME|Container hostname|^[a-zA-Z][a-zA-Z0-9-]*$
CONTAINER_MEMORY|Container memory limit|^[0-9]+[gGmM]$
CONTAINER_CPUS|Container CPU limit|^[0-9]+(\\.[0-9]+)?$
CONTAINER_SHM_SIZE|Container shared memory size|^[0-9]+[gGmM]$
GIT_USER_NAME|Git author name|^[a-zA-Z0-9 ._-]+$
GIT_USER_EMAIL|Git author email|^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+\.[a-zA-Z]{2,}$
EDITOR_CHOICE|Editor selection|^(code|cursor|antigravity)$
DOCKER_IMAGE_NAME|Docker image name|^[a-z0-9][a-z0-9._-]+$
DOCKER_IMAGE_TAG|Docker image tag|^[a-zA-Z0-9][a-zA-Z0-9._-]+$
ANSIBLE_VERSION|Ansible core version|^[0-9]+(\.[0-9]+)*(\.\*)?$
ANSIBLE_LINT_VERSION|Ansible-lint version|^[0-9]+(\.[0-9]+)*(\.\*)?$
YAMLLINT_VERSION|Yamllint version|^[0-9]+(\.[0-9]+)*(\.\*)?$
EOF

printf '\nValidating optional variables...\n'
while IFS='|' read -r var description pattern; do
    [ -z "$var" ] && continue
    eval "value=\${$var:-}"
    if [ -n "$value" ]; then
        if ! validate_var "$var" "$value" "$pattern" "$description"; then
            errors=$((errors + 1))
        fi
    fi
done <<'EOF'
GIT_REMOTE_URL|Git remote URL|^(https://|git@).+
EOF

if [ "$errors" -gt 0 ]; then
    printf '\nFound %s error(s). Please fix them and try again.\n' "$errors"
    exit 1
else
    printf '\nAll environment variables are valid!\n'
fi
