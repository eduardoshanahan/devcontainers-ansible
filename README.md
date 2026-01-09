# Devcontainer Ansible Template

This repo provides a devcontainer-backed Ansible workflow with a validated
environment loader, helper launch scripts, and a ready-to-use `src/` layout for
playbooks, inventory, and roles.

## Quick Start

1. Copy `.env.example` to `.env`, then run `./editor-launch.sh` (GUI) or `./devcontainer-launch.sh` (CLI).
2. Reopen in container (VS Code/Cursor/Antigravity) to use the preconfigured Ansible tools.
3. Update inventory and playbooks under `src/`.
4. Run the sample playbook: `ansible-playbook src/playbooks/sample.yml -i src/inventory/hosts.ini`.

## Key Docs

- Documentation index: [documentation/README.md](documentation/README.md)
- Setup of environment variables: [working with environment variables](documentation/working%20with%20environment%20variables.md)
- Daily workflow and usage: [how to use this project.md](documentation/how%20to%20use%20this%20project.md)
- Validation and smoke tests: [how to test.md](documentation/how%20to%20test.md)
- Troubleshooting: [troubleshooting.md](documentation/troubleshooting.md)
- Git sync helper: [how to use sync-git.md](documentation/how%20to%20use%20sync-git.md)
- Devcontainer CLI: [how to use devcontainer cli.md](documentation/how%20to%20use%20devcontainer%20cli.md)
- Claude Code: [how to use claude.md](documentation/how%20to%20use%20claude.md)
- Image cleanup: [how to clean devcontainer images.md](documentation/how%20to%20clean%20devcontainer%20images.md)
- File sync and ownership: [file sync and ownership.md](documentation/file%20sync%20and%20ownership.md)
- Daily timeline + summaries: [documentation/daily/recaps](documentation/daily/recaps)
- Current state: [documentation/daily/state](documentation/daily/state)
- Roadmap and decisions: [documentation/daily/plans](documentation/daily/plans)

## Documentation Directory

All project docs live under `documentation/`:

- How-to guides: `documentation/*.md` (setup, testing, troubleshooting, workflows).
- Architecture Decision Records (ADRs): `documentation/adr/`.
- Daily journal: `documentation/daily/` (project state, plans, and recaps by date).

## Helpful Scripts

- Lint + smoke checks: `scripts/ansible-smoke.sh`
- Devcontainer image cleanup: `scripts/clean-devcontainer-images.sh`
- Devcontainer launchers:
  - `editor-launch.sh` (GUI)
  - `devcontainer-launch.sh` (CLI shell)
  - `claude-launch.sh` (CLI, launches Claude Code)

## Notes

- Ansible paths are host-driven; set `ANSIBLE_CONFIG`, `ANSIBLE_INVENTORY`, `ANSIBLE_COLLECTIONS_PATH`, and `ANSIBLE_ROLES_PATH` in your host environment (commonly pointing at `src/`).
- Environment values come from `.env` and are validated before launch.
- Galaxy dependencies are defined in `src/requirements.yml` and installed in post-create.
