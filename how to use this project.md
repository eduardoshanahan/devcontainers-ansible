# How to Use This Project

This document describes the day-to-day workflow for using the devcontainer
Ansible template. Update it as you add roles, inventories, or new tooling.

## 0. Configure the Devcontainer Environment

1. Copy the root `.env.example` to `.env` so the devcontainer picks up required
   environment variables:

   ```bash
   cp .env.example .env
   ```

2. Edit `.env` and set the required values (host user/UID/GID, git identity,
   editor choice, Docker naming, resource limits, and Ansible tool versions).

3. Launch the devcontainer:
   - `./launch.sh` for VS Code/Cursor/Antigravity.
   - `./devcontainer_launch.sh` for a CLI shell.
   - `./claude_launch.sh` to start Claude Code inside the container.

The launch scripts load `.env` and run `.devcontainer/scripts/validate-env.sh`
before starting the container.

## 1. Update Inventory and Playbooks

- Inventory lives in `src/inventory/hosts.ini`.
- Global variables live in `src/group_vars/all.yml`.
- Playbooks live in `src/playbooks/`.
- Add or update roles in `src/roles/`.

## 2. Run Ansible

From inside the devcontainer, run:

```bash
ansible-playbook src/playbooks/sample.yml -i src/inventory/hosts.ini
```

If you add new playbooks, keep them under `src/playbooks/` and reference the
inventory under `src/inventory/`.

## 3. Keep Galaxy Dependencies in Sync

- Manage collections and roles in `src/requirements.yml`.
- The post-create hook installs dependencies automatically, and you can
  re-run it with:

```bash
ansible-galaxy collection install -r src/requirements.yml --force
ansible-galaxy role install -r src/requirements.yml --force
```
