# Working with environment variables (TL;DR)

1. **Copy the template:** `cp .env.example .env` (only needs to happen once per project).
2. **Fill in the values:** edit `.env` so that `PROJECT_NAME`, `HOST_USERNAME`, `HOST_UID`, `HOST_GID`, `GIT_USER_NAME`, `GIT_USER_EMAIL`, `EDITOR_CHOICE` (code/cursor/antigravity), `CONTAINER_HOSTNAME`, `DOCKER_IMAGE_NAME`, resource limits, and `ANSIBLE_VERSION`/`ANSIBLE_LINT_VERSION`/`YAMLLINT_VERSION` match your machine. `GIT_REMOTE_URL` is optional. This file is the single source of truth; `.devcontainer/config/.env` only provides defaults.
3. **Optionally reuse defaults:** if a variable is missing from `.env`, the loader fills it from `.devcontainer/config/.env`, so you can leave optional values blank.
4. **Validate & launch:** always start your session with `./launch.sh` for editor workflows, or use `./devcontainer_launch.sh` / `./claude_launch.sh` for CLI workflows. These load `.env`, run `.devcontainer/scripts/validate-env.sh`, and only launch after the check passes. If something is wrong, the script exits with the list of fixes so you don’t waste time booting the devcontainer.
5. **Inside the container:** every helper script sources `.devcontainer/scripts/env-loader.sh`, so anything defined in `.env` automatically shows up in init/post-create hooks and in your shell.
6. **Adding new variables:** document them in `.env.example`, consume them via `env-loader.sh`, and (if they’re required) add a rule to `.devcontainer/scripts/validate-env.sh`. No other script needs to change. For multiple git remotes, set `GIT_SYNC_REMOTES`, `GIT_SYNC_PUSH_REMOTES`, and matching `GIT_REMOTE_URL_<REMOTE>` entries here as well.

Keep `.env` out of version control (already covered by `.gitignore`) so each machine can store its own user-specific values without conflicts.
