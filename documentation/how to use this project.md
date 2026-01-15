# How to use this project

## Overview

This document describes the day-to-day workflow for using the devcontainer
Ansible template. Update it as you add roles, inventories, or new tooling.

## Quick start

1. Copy `.env.example` to `.env` so the devcontainer picks up required environment variables:

   ```bash
   cp .env.example .env
   ```

2. Edit `.env` and set the required values (host user/UID/GID, locale, Git identity, editor choice, resource limits, and Ansible tool versions).

## Launchers

- `./editor-launch.sh` for VS Code/Cursor/Antigravity.
- `./devcontainer-launch.sh` for a CLI shell.
- `./claude-launch.sh` to start Claude Code inside the container.
- `./workspace.sh` to open a tmux workspace on the host (optional).

## SSH agent forwarding

The devcontainer bind-mounts `SSH_AUTH_SOCK`, so the host must have a running
SSH agent before the container starts.

## Common scripts

- Validate config: `./scripts/validate-env.sh [editor|devcontainer|claude]`
- Clean old devcontainer images: `./scripts/clean-devcontainer-images.sh`
- Sync git remotes (optional): `./scripts/sync-git.sh`

## Project-specific workflow

### Update inventory and playbooks

- Inventory lives in `src/inventory/hosts.ini`.
- Global variables live in `src/group_vars/all.yml`.
- Playbooks live in `src/playbooks/`.
- Add or update roles in `src/roles/`.

### Run Ansible

From inside the devcontainer, run:

```bash
ansible-playbook src/playbooks/sample.yml -i src/inventory/hosts.ini
```

If you add new playbooks, keep them under `src/playbooks/` and reference the
inventory under `src/inventory/`.

### Keep Galaxy dependencies in sync

- Manage collections and roles in `src/requirements.yml`.
- The post-create hook installs dependencies automatically, and you can
  re-run it with:

```bash
ansible-galaxy collection install -r src/requirements.yml --force
ansible-galaxy role install -r src/requirements.yml --force
```
