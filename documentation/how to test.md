# How to Test

Use these checks to confirm the devcontainer and Ansible toolchain are healthy.

## 1. Smoke Test (Lint + Sample Playbook)

Run the helper script (inside the devcontainer):

```bash
./scripts/ansible-smoke.sh
```

To target a different playbook:

```bash
./scripts/ansible-smoke.sh path/to/playbook.yml
```

## 2. Manual Linting

```bash
ansible-lint src/playbooks/sample.yml
yamllint src
```

## 3. Manual Playbook Run

```bash
ansible-playbook src/playbooks/sample.yml -i src/inventory/hosts.ini
```
