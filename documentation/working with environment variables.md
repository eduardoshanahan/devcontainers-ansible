# Working with environment variables (TL;DR)

1. **Copy the template:** `cp .env.example .env` (only needs to happen once per project).
2. **Fill in the values:** edit `.env` so that `PROJECT_NAME`, `HOST_USERNAME`, `HOST_UID`, `HOST_GID`, `WORKSPACE_FOLDER`, `GIT_USER_NAME`, `GIT_USER_EMAIL`, `GIT_SSH_HOST`, `EDITOR_CHOICE` (code/cursor/antigravity), `CONTAINER_HOSTNAME`, `DOCKER_IMAGE_NAME`, resource limits, and `ANSIBLE_CORE_VERSION`/`ANSIBLE_LINT_VERSION`/`YAMLLINT_VERSION` match your machine. `GIT_REMOTE_URL` is optional. This file is the single source of truth.
3. **No fallback defaults:** the project root `.env` is the only source of configuration, so every required value must be present there.
4. **Validate & launch:** always start your session with `./editor-launch.sh` for editor workflows, or use `./devcontainer-launch.sh` / `./claude-launch.sh` for CLI workflows. These load `.env`, run `.devcontainer/scripts/validate-env.sh`, and only launch after the check passes. If something is wrong, the script exits with the list of fixes so you don’t waste time booting the devcontainer.
5. **Inside the container:** helper scripts source `.devcontainer/scripts/env-loader.sh`, and it requires `WORKSPACE_FOLDER` (or an explicit path argument) to locate the project `.env`.
6. **Adding new variables:** document them in `.env.example`, consume them via `env-loader.sh`, and (if they’re required) add a rule to `.devcontainer/scripts/validate-env.sh`. No other script needs to change. For multiple git remotes, set `GIT_SYNC_REMOTES`, `GIT_SYNC_PUSH_REMOTES`, and matching `GIT_REMOTE_URL_<REMOTE>` entries here as well. Optional cleanup knobs like `DEVCONTAINER_IMAGE_RETENTION_DAYS` live here too.

Keep `.env` out of version control (already covered by `.gitignore`) so each machine can store its own user-specific values without conflicts.
