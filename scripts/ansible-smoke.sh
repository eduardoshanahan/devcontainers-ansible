#!/usr/bin/env bash

set -euo pipefail

REPO_ROOT="$(cd "$(dirname "${BASH_SOURCE[0]}")/.." && pwd)"
ANSIBLE_ROOT="${REPO_ROOT}/src"
ANSIBLE_CFG="${ANSIBLE_ROOT}/ansible.cfg"
INVENTORY_DIR="${ANSIBLE_ROOT}/inventory"
PLAYBOOK="${1:-${ANSIBLE_ROOT}/playbooks/sample.yml}"
INVENTORY="${2:-${INVENTORY_DIR}/hosts.ini}"

if ! command -v ansible >/dev/null 2>&1; then
    echo "ansible command not found; run this script inside the devcontainer." >&2
    exit 1
fi

export ANSIBLE_CONFIG="$ANSIBLE_CFG"
export ANSIBLE_INVENTORY="$INVENTORY_DIR"

echo ">>> Ansible version"
ansible --version | head -n 2
echo

if command -v ansible-lint >/dev/null 2>&1; then
    echo ">>> Running ansible-lint on ${PLAYBOOK}"
    ansible-lint "$PLAYBOOK"
    echo
else
    echo "ansible-lint not available; skipping lint step." >&2
fi

if command -v yamllint >/dev/null 2>&1; then
    echo ">>> Running yamllint on ${ANSIBLE_ROOT}"
    yamllint "$ANSIBLE_ROOT"
    echo
else
    echo "yamllint not available; skipping YAML lint step." >&2
fi

echo ">>> Executing ansible-playbook ${PLAYBOOK} (inventory: ${INVENTORY})"
ansible-playbook -i "$INVENTORY" "$PLAYBOOK"
