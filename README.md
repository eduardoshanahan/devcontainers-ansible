# Devcontainer Ansible Template

This repo provides a devcontainer-backed Ansible workflow with a validated
environment loader, helper launch scripts, and a ready-to-use `src/` layout for
playbooks, inventory, and roles.

## Quick Start

1. Copy `.env.example` to `.env`, then run `./launch.sh` (GUI) or `./devcontainer_launch.sh` (CLI).
2. Reopen in container (VS Code/Cursor/Antigravity) to use the preconfigured Ansible tools.
3. Update inventory and playbooks under `src/`.
4. Run the sample playbook: `ansible-playbook src/playbooks/sample.yml -i src/inventory/hosts.ini`.

## Key Docs

- Setup of environment variables: [working with environment variables](working%20with%20environment%20variables.md)
- Daily workflow and usage: [how to use this project.md](how%20to%20use%20this%20project.md)
- Validation and smoke tests: [how to test.md](how%20to%20test.md)
- Daily timeline + summaries: [lm/recaps](lm/recaps)
- Current state: [lm/state](lm/state)
- Roadmap and decisions: [lm/plans](lm/plans)

## Helpful Scripts

- Lint + smoke checks: `scripts/ansible-smoke.sh`
- Devcontainer launchers:
  - `launch.sh` (GUI)
  - `devcontainer_launch.sh` (CLI shell)
  - `claude_launch.sh` (CLI, launches Claude Code)

## Notes

- All Ansible code lives under `src/`; the container sets `ANSIBLE_CONFIG` to `src/ansible.cfg`.
- Environment values come from `.env` and are validated before launch.
- Galaxy dependencies are defined in `src/requirements.yml` and installed in post-create.
