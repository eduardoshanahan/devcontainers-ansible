# Ansible Development Environment in Devcontainers

This repository provides a ready-to-use development environment using
devcontainers, supporting both Visual Studio Code and Cursor editors. It ensures
consistent Git configuration and proper file permissions whether you're working
inside the container or on the host machine. It is focused on working with
Ansible without installing anything in the local machine.

## Table of Contents

- [Ansible Development Environment in Devcontainers](#ansible-development-environment-in-devcontainers)
  - [Table of Contents](#table-of-contents)
  - [Features](#features)
  - [Prerequisites](#prerequisites)
  - [Quick Start](#quick-start)
    - [1. Clone and Initialize](#1-clone-and-initialize)
    - [2. Configure Environment](#2-configure-environment)
    - [Docker Image Management](#docker-image-management)
    - [Docker Image Management](#docker-image-management-1)
    - [3. Launch the Environment](#3-launch-the-environment)
  - [Included Tools and Features](#included-tools-and-features)
    - [Development Tools](#development-tools)
    - [Git Aliases](#git-aliases)
  - [VS Code Extensions](#vs-code-extensions)
  - [Configuration](#configuration)
    - [Ansible Configuration](#ansible-configuration)
    - [Git Configuration](#git-configuration)
    - [Example Role and Testing](#example-role-and-testing)
  - [Git Workflow](#git-workflow)
    - [Repository Synchronization](#repository-synchronization)
      - [Script Behavior](#script-behavior)
      - [Common Use Cases](#common-use-cases)
      - [Troubleshooting](#troubleshooting)
    - [Commit Message Format](#commit-message-format)
      - [Types](#types)
      - [Types](#types-1)
      - [Scope](#scope)
      - [Description](#description)
      - [Examples](#examples)
      - [Breaking Changes](#breaking-changes)
    - [Pre-commit Checks](#pre-commit-checks)
  - [Troubleshooting](#troubleshooting-1)
    - [Permission Issues](#permission-issues)
    - [Editor Launch Issues](#editor-launch-issues)
    - [Git Configuration](#git-configuration-1)
  - [Testing Git Setup](#testing-git-setup)
    - [1. Check Git Installation and Configuration](#1-check-git-installation-and-configuration)
    - [2. Test Basic Git Operations](#2-test-basic-git-operations)
    - [3. Verify Git Aliases](#3-verify-git-aliases)
  - [Testing Ansible Setup](#testing-ansible-setup)
    - [1. Check Ansible Installation and Configuration](#1-check-ansible-installation-and-configuration)
    - [2. Test Basic Ansible Operations](#2-test-basic-ansible-operations)
    - [3. Verify Ansible Tools](#3-verify-ansible-tools)
    - [4. Ansible Setup Checklist](#4-ansible-setup-checklist)
    - [5. Common Issues and Solutions](#5-common-issues-and-solutions)
  - [Directory Structure](#directory-structure)
  - [Testing and Setup Scripts](#testing-and-setup-scripts)
    - [Pre-commit Hooks](#pre-commit-hooks)
    - [Markdown Testing](#markdown-testing)
    - [Ansible Testing](#ansible-testing)
    - [Shell Script Testing](#shell-script-testing)
    - [Git Setup Script](#git-setup-script)
    - [Launch Script](#launch-script)
    - [Environment Setup](#environment-setup)
    - [VS Code Tasks](#vs-code-tasks)

## Features

- Secure user permissions matching host system
- Consistent Git configuration across environments
- Pre-configured development tools and utilities
- Support for both VS Code and Cursor editors
- Customized shell with useful aliases and tools
- GitHub CLI integration
- Enhanced code search and navigation
- Ansible development tools and configuration

## Prerequisites

- Ubuntu (tested on Ubuntu 24.10)
- Docker installed and running
- One of the following editors:
  - Visual Studio Code with Remote - Containers extension
  - Cursor Editor

## Quick Start

### 1. Clone and Initialize

```bash
# Clone the repository
git clone --depth 1 https://github.com/eduardoshanahan/devcontainers-ansible new-project-name
cd new-project-name

# Remove Git history to start fresh
rm -rf .git/
git init
```

### 2. Configure Environment

```bash
# Copy environment template
cp .devcontainer/.env.example .devcontainer/.env

# Get your user details (note these values)
echo "Your username: $(whoami)"
echo "Your UID: $(id -u)"
echo "Your GID: $(id -g)"

# Edit the environment file
code .devcontainer/.env  # or cursor .devcontainer/.env
```

Required environment variables:

```dotenv
# User configuration
HOST_USERNAME="your_username"     # Output of whoami
HOST_UID=1000                     # Output of id -u
HOST_GID=1000                     # Output of id -g

# Git configuration
GIT_USER_NAME="Your Name"         # Your Git username
GIT_USER_EMAIL="your@email.com"   # Your Git email

# Editor configuration
EDITOR_CHOICE=code               # Use 'code' for VS Code or 'cursor' for Cursor

# Docker configuration
DOCKER_IMAGE_NAME="your-image"    # Name for the Docker image
DOCKER_IMAGE_TAG="1.0.0"         # Tag for the Docker image
```

### Docker Image Management

By default, VS Code creates Docker images with auto-generated names. To use
custom names:

1. Set these variables in `.devcontainer/.env`:

```bash
# Copy environment template
cp .devcontainer/.env.example .devcontainer/.env

# Get your user details (note these values)
echo "Your username: $(whoami)"
echo "Your UID: $(id -u)"
echo "Your GID: $(id -g)"

# Edit the environment file
code .devcontainer/.env  # or cursor .devcontainer/.env
```

Required environment variables:

```dotenv
# User configuration
HOST_USERNAME="your_username"     # Output of whoami
HOST_UID=1000                     # Output of id -u
HOST_GID=1000                     # Output of id -g

# Git configuration
GIT_USER_NAME="Your Name"         # Your Git username
GIT_USER_EMAIL="your@email.com"   # Your Git email

# Editor configuration
EDITOR_CHOICE=code               # Use 'code' for VS Code or 'cursor' for Cursor

# Docker configuration
DOCKER_IMAGE_NAME="your-image"    # Name for the Docker image
DOCKER_IMAGE_TAG="1.0.0"         # Tag for the Docker image
```

### Docker Image Management

By default, VS Code creates Docker images with auto-generated names. To use
custom names:

1. Set these variables in `.devcontainer/.env`:

```bash
DOCKER_IMAGE_NAME="your-image-name"
DOCKER_IMAGE_TAG="your-tag"
```

1. To clean up old images and rebuild with new names:

```bash
# Stop containers using old images
docker stop $(docker ps -q --filter ancestor=<old-image-name>)

# Remove old images
docker image rm <old-image-name>:latest
docker image rm <old-image-name-uid>:latest

# Rebuild with new name
./launch.sh
```

The container will be rebuilt with your specified image name and tag.

### 3. Launch the Environment

The `launch.sh` script in the root directory will help you start the development
environment:

```bash
# Launch your chosen editor (VS Code or Cursor)
./launch.sh
```

The script will:

- Validate your environment configuration
- Check if your chosen editor is installed
- Clean up any existing containers
- Launch the appropriate editor

If there are any issues, the script will provide helpful error messages and
instructions.

## Included Tools and Features

### Development Tools

- Git with enhanced configuration
- GitHub CLI
- Build essentials
- curl, wget, jq
- zip/unzip utilities
- tree, htop
- bash-completion
- Ansible and related tools

### Git Aliases

| Alias | Command                   | Description                      |
| ----- | ------------------------- | -------------------------------- |
| gs    | git status                | Show working tree status         |
| gp    | git pull                  | Pull changes from remote         |
| gd    | git diff                  | Show file differences            |
| gc    | git commit                | Create a commit                  |
| gb    | git branch                | List or manage branches          |
| gl    | git log --oneline --graph | Show commit history graph        |
| gco   | git checkout              | Switch branches or restore files |
| gf    | git fetch --all --prune   | Update remote references         |
| gst   | git stash                 | Stash changes                    |
| gstp  | git stash pop             | Apply stashed changes            |

## VS Code Extensions

The environment comes with pre-configured extensions for:

- Docker and container management
- Git integration and visualization
- Code intelligence and completion
- Markdown support
- Code formatting and linting
- Spell checking
- File icons and themes
- Ansible support

## Configuration

The project uses a centralized configuration approach with all configuration
files stored in the `config/` directory:

```text
config/
├── ansible/
│   └── ansible.cfg    # Ansible configuration
└── git/
    └── .gitlint      # Git commit message rules
```

Symlinks in the project root maintain compatibility with tools while keeping
configurations organized:

- `.gitlint -> config/git/.gitlint`
- `ansible.cfg -> config/ansible/ansible.cfg`

### Ansible Configuration

The Ansible configuration (`config/ansible/ansible.cfg`) includes:

1. **Inventory Settings**:

   - Default inventory directory: `inventory/`
   - Disabled host key checking for development
   - Roles path configured to `roles/`

2. **Performance Optimizations**:

   - Smart fact gathering
   - JSON fact caching enabled
   - Cache timeout: 2 hours
   - Increased fork count for parallel execution

3. **SSH Settings**:

   - Pipelining enabled
   - Persistent connections
   - Public key authentication preferred
   - Custom control path for SSH multiplexing

4. **Security and Privilege Escalation**:

   - Sudo-based privilege escalation
   - Vault integration
   - SSH key-based authentication

### Git Configuration

The Git commit message configuration (`config/git/.gitlint`) enforces:

1. **Commit Message Format**:

   ```
   type(scope): description

   [optional body]
   [optional footer]
   ```

2. **Commit Types**:

   - `feat`: New features
   - `fix`: Bug fixes
   - `docs`: Documentation changes
   - `style`: Code style changes
   - `refactor`: Code refactoring
   - `perf`: Performance improvements
   - `test`: Testing changes
   - `build`: Build system changes
   - `ci`: CI configuration changes
   - `chore`: Maintenance tasks
   - `revert`: Reverting changes
   - `bump`: Version bumps

3. **Validation Rules**:

   - Title length: maximum 72 characters
   - Body is optional (rule B6 ignored)
   - Scope is optional but must be in parentheses
   - Description must be in imperative mood

4. **Special Commits**:

   - Merge commits ignored
   - Revert commits ignored
   - Fixup commits ignored
   - Squash commits ignored

### Example Role and Testing

The repository includes a basic test role structure to verify the Ansible setup:

```text
src/
├── playbooks/
│   └── test_role.yml    # Test playbook for role verification
└── roles/
    └── test_role/      # Example role structure
        └── tasks/
            └── main.yml  # Basic task for testing
```

Example task content (`src/roles/test_role/tasks/main.yml`):

```yaml
---
- name: Test role task
  ansible.builtin.debug:
    msg: "Test role is working correctly!"
```

To verify your Ansible setup:

1. **Run the test playbook**:

   ```bash
   ansible-playbook src/playbooks/test_role.yml
   ```

2. **Expected output**:

   - Successful connection to localhost
   - Debug message: "Test role is working correctly!"
   - No errors in the playbook recap

This test confirms:

- Correct Ansible configuration
- Proper role path configuration
- Working playbook execution
- Successful role inclusion
- Compliance with Ansible best practices (FQCN usage)

## Git Workflow

This project uses several tools to maintain high code quality and consistent Git
practices:

### Repository Synchronization

The repository includes a `sync_git.sh` script to help maintain synchronization
with the remote repository. When working inside the devcontainer, you can run it
in several ways:

1. From the workspace root (recommended):

   ```bash
   ./scripts/sync_git.sh
   ```

2. Using the absolute path (from any directory):

   ```bash
   /workspace/scripts/sync_git.sh
   ```

3. With force pull option (overwrites local changes):

   ```bash
   FORCE_PULL=true ./scripts/sync_git.sh
   ```

4. With a different branch:

   ```bash
   BRANCH=develop ./scripts/sync_git.sh
   ```

The script provides the following features:

- Automatically initializes git repository if not present
- Sets up the correct remote URL
- Syncs with the remote repository
- Creates backups of local changes when force pulling
- Provides colored output for better readability
- Handles detached HEAD states automatically

#### Script Behavior

1. **Normal Operation**:

   - Checks for local changes
   - Pulls latest changes from remote
   - Fails if there are uncommitted changes

2. **Force Pull Mode**:

   - Backs up any local changes
   - Forces sync with remote branch
   - Removes untracked files
   - Use with caution: `FORCE_PULL=true`

3. **Error Handling**:

   - Provides clear error messages
   - Creates backups before destructive operations
   - Guides you through fixing common issues

4. **Safety Features**:

   - Won't overwrite uncommitted changes without FORCE_PULL
   - Creates backups of local changes
   - Validates git configuration before operations

#### Common Use Cases

1. **Initial Setup**:

   ```bash
   cd /workspace
   ./scripts/sync_git.sh
   ```

2. **Daily Updates**:

   ```bash
   # From workspace root
   ./scripts/sync_git.sh
   ```

3. **Discarding Local Changes**:

   ```bash
   # Will backup changes first
   FORCE_PULL=true ./scripts/sync_git.sh
   ```

4. **Working with Feature Branches**:

   ```bash
   BRANCH=feature/my-feature ./scripts/sync_git.sh
   ```

#### Troubleshooting

If you encounter issues:

1. **Uncommitted Changes**:

   ```bash
   # Either commit your changes:
   git commit -m "feat(scope): your changes"
   ./scripts/sync_git.sh

   # Or force pull (will backup changes):
   FORCE_PULL=true ./scripts/sync_git.sh
   ```

2. **Wrong Branch**:

   ```bash
   # Specify the correct branch:
   BRANCH=main ./scripts/sync_git.sh
   ```

3. **No Remote URL**:

   ```bash
   # Set up your remote first:
   git remote add origin <your-repository-url>
   ./scripts/sync_git.sh
   ```

### Commit Message Format

We follow the [Conventional Commits](https://www.conventionalcommits.org/)
specification for commit messages. Each commit message should be structured as
follows:

```text
<type>(<scope>): <description>

[optional body]

[optional footer(s)]
```

#### Types

We follow the [Conventional Commits](https://www.conventionalcommits.org/)
specification for commit messages. Each commit message should be structured as
follows:

```text
<type>(<scope>): <description>

[optional body]

[optional footer(s)]
```

#### Types

- `feat`: A new feature
- `fix`: A bug fix
- `feat`: A new feature
- `fix`: A bug fix
- `docs`: Documentation changes
- `style`: Code style changes (formatting, missing semicolons, etc.)
- `refactor`: Code changes that neither fix a bug nor add a feature
- `perf`: Code changes that improve performance
- `test`: Adding missing tests or correcting existing tests
- `build`: Changes that affect the build system or external dependencies
- `ci`: Changes to CI configuration files and scripts
- `chore`: Other changes that don't modify src or test files
- `revert`: Revert a previous commit
- `bump`: Version bump

#### Scope

The scope should be the name of the component affected (e.g., ansible, git,
docker).

#### Description

- Use the imperative, present tense: "add" not "added" or "adds"
- Don't capitalize first letter
- No dot (.) at the end

#### Examples

```text
feat(ansible): add new role for nginx configuration

Add a new Ansible role for managing Nginx installations. This role includes:
- Basic installation and configuration
- Virtual host management
- SSL certificate handling
- Security hardening options

fix(docker): resolve permission issues in volume mounts

Fixed file permission problems when mounting volumes in Docker containers.
Updated the Dockerfile to ensure proper UID/GID mapping and file ownership.
This resolves issues with write permissions in mounted directories.

docs(readme): update installation instructions

Improved the clarity of installation steps and added troubleshooting guides.
Added examples for common setup scenarios and expanded the prerequisites
section with more detailed system requirements.

style(yaml): format all playbooks using yamllint

Applied consistent YAML formatting across all playbooks and roles.
Updated indentation, removed trailing spaces, and ensured proper document
structure according to yamllint rules.

test(roles): add integration tests for mysql role

Added comprehensive integration tests for the MySQL role:
- Database creation and user management tests
- Replication setup verification
- Backup and restore procedures
- Performance optimization checks
```

#### Breaking Changes

For breaking changes, add `BREAKING CHANGE:` in the footer and append `!` after
the scope:

```text
feat(api)!: update authentication method

Implemented JWT-based authentication to replace the existing token system.
Added support for refresh tokens and enhanced security measures.

BREAKING CHANGE: `auth_token` is now required for all API calls and must be
in JWT format. Previous authentication methods will stop working after the
next release.
```

### Pre-commit Checks

The following checks run automatically before commits:

- Code formatting (Black, Prettier)
- YAML validation
- Ansible lint
- Security checks (GitLeaks)
- Line ending validation
- Merge conflict detection
- Private key detection

Run checks manually:

```bash
pre-commit run --all-files
```

## Troubleshooting

### Permission Issues

```bash
# Verify your host machine IDs match .env
id -u  # Should match HOST_UID
id -g  # Should match HOST_GID

# Check container user
docker exec <container-name> id
```

### Editor Launch Issues

```bash
# Check if editor is installed
command -v code    # For VS Code
command -v cursor  # For Cursor

# Verify environment variables
cat .devcontainer/.env
```

### Git Configuration

```bash
# Verify Git configuration
git config --global --list

# Reset Git configuration if needed
git config --global --unset-all user.name
git config --global --unset-all user.email
```

## Testing Git Setup

To verify that Git is working correctly in your container, follow these steps:

### 1. Check Git Installation and Configuration

```bash
# Verify Git version and configuration
git --version
git config --global --list
```

Expected output should show:

- Git version installed
- Your configured username and email
- Core settings like editor, file mode, etc.

### 2. Test Basic Git Operations

```bash
# Create and stage a test file
echo "test content" > test.txt
git add test.txt
git status  # Should show test.txt as staged

# Create a test commit
git commit -m "test commit" test.txt
git log -1  # Should show your commit

# Test file modifications
rm test.txt
git status  # Should show test.txt as deleted
```

### 3. Verify Git Aliases

```bash
# Test common aliases
gs   # git status
gl   # git log with graph
gd   # git diff
```

## Testing Ansible Setup

To verify that Ansible is working correctly in your container, follow these
steps:

### 1. Check Ansible Installation and Configuration

```bash
# Verify Ansible version and configuration
ansible --version
ansible-config dump --only-changed

# Check Ansible collections
ansible-galaxy collection list

# Verify Ansible roles
ansible-galaxy role list
```

Expected output should show:

- Ansible version installed
- Core configuration settings
- Installed collections and roles

### 2. Test Basic Ansible Operations

```bash
# Test inventory parsing
ansible-inventory --list

# Test playbook syntax
ansible-playbook --syntax-check src/playbooks/*.yml

# Run a simple ping test
ansible all -m ping -i hosts.ini

# Test playbook execution
ansible-playbook src/playbooks/test.yml -i hosts.ini
```

### 3. Verify Ansible Tools

```bash
# Test ansible-lint
ansible-lint src/playbooks/*.yml

# Test ansible-doc
ansible-doc ping

# Test ansible-galaxy
ansible-galaxy init test_role
```

### 4. Ansible Setup Checklist

✓ Ansible installation:

- Ansible command works
- Correct version is installed
- Configuration is properly set
- Collections and roles are installed

✓ Basic operations:

- Inventory parsing works
- Playbook syntax checking works
- Ping module works
- Playbook execution works

✓ Development tools:

- ansible-lint is working
- ansible-doc is accessible
- ansible-galaxy is functional

✓ Permissions:

- Can create and modify playbooks
- Can create and modify roles
- Can access inventory files
- Can execute playbooks

### 5. Common Issues and Solutions

If you encounter issues:

1. Check Ansible configuration:

```bash
# View current configuration
ansible-config dump

# Check for configuration errors
ansible-config dump --only-changed
```

1. Verify Python environment:

```bash
# Check Python version
python3 --version

# Verify pip packages
pip list | grep ansible
```

1. Test SSH connectivity:

```bash
# Test SSH to target hosts
ssh -i ~/.ssh/id_rsa user@target-host
```

1. Check file permissions:

```bash
# Verify playbook permissions
ls -l src/playbooks/
ls -l src/roles/
```

## Directory Structure

```text
.
├── .github/              # GitHub specific files
├── .devcontainer/        # Dev container configuration
├── .vscode/             # VS Code workspace settings
├── .cursor/             # Cursor rules and configurations
├── config/              # Configuration files
│   └── ansible/         # Ansible-specific configurations
├── scripts/             # Shell scripts and utilities
│   ├── launch.sh        # Development environment launcher
│   └── sync-git.sh      # Git synchronization utility
├── src/                 # Source directory
│   ├── inventory/       # Ansible inventory files
│   ├── playbooks/       # Ansible playbooks
│   └── roles/          # Ansible roles
└── tests/              # Test files
```

For detailed workspace organization rules, see
`.cursor/rules/workspace-organization.md`.

## Testing and Setup Scripts

### Pre-commit Hooks

The project uses pre-commit hooks to ensure code quality and consistency:

```bash
# Install pre-commit hooks
pre-commit install --install-hooks

# Run pre-commit hooks on all files
pre-commit run --all-files
```

Available hooks:

- `trailing-whitespace`: Removes trailing whitespace
- `end-of-file-fixer`: Ensures files end with a newline
- `check-yaml`: Validates YAML files
- `check-added-large-files`: Prevents large files from being committed
- `check-merge-conflict`: Checks for merge conflict markers
- `detect-private-key`: Prevents accidental commit of private keys
- `check-case-conflict`: Checks for case conflicts in filenames
- `forbid-new-submodules`: Prevents new submodules
- `mixed-line-ending`: Checks for mixed line endings
- `ansible-lint`: Lints Ansible files
- `black`: Formats Python code
- `yamllint`: Lints YAML files
- `gitleaks`: Checks for secrets
- `commitizen`: Enforces commit message format
- `gitlint`: Validates commit messages
- `prettier`: Formats JSON and YAML files
- `mdformat`: Formats Markdown files
- `forbid-crlf`: Prevents CRLF line endings
- `remove-crlf`: Converts CRLF to LF
- `forbid-tabs`: Prevents tabs in files
- `remove-tabs`: Converts tabs to spaces

### Markdown Testing

The project includes markdown formatting tests:

```bash
# Run markdown tests
./config/markdown/tests/test-format.sh
```

This script:

- Checks for `mdformat` installation
- Formats all markdown files
- Validates formatting rules
- Reports any issues

### Ansible Testing

The project includes several Ansible testing tools:

```bash
# Run ansible-lint
ansible-lint

# Run yamllint
yamllint

# Run molecule tests (if configured)
molecule test

# Run test playbook
ansible-playbook src/playbooks/test.yml
```

### Shell Script Testing

Shell scripts are validated using:

```bash
# Run shellcheck
shellcheck scripts/*.sh

# Format shell scripts
shfmt -i 2 -ci -bn scripts/*.sh
```

### Git Setup Script

The `sync_git.sh` script helps manage Git configuration:

```bash
# Run the sync script
./scripts/sync_git.sh

# Options:
# -h, --help     Show help message
# -v, --verbose  Show detailed output
# -f, --force    Force update of Git configuration
```

This script:

- Syncs Git configuration between host and container
- Updates Git user information
- Configures Git editor preferences
- Sets up Git hooks
- Manages Git credentials

### Launch Script

The `launch.sh` script manages the development environment:

```bash
# Launch the environment
./launch.sh

# Options:
# -h, --help     Show help message
# -v, --verbose  Show detailed output
# -c, --clean    Clean up existing containers
# -r, --rebuild  Rebuild the container
```

This script:

- Validates environment configuration
- Checks editor installation
- Manages Docker containers
- Launches the appropriate editor
- Handles error cases

### Environment Setup

The project uses several environment files:

1. `.devcontainer/.env`:

   - User configuration
   - Git settings
   - Editor preferences
   - Docker settings

2. `.env.example`:

   - Template for environment variables
   - Example values and documentation

3. `.env.local` (optional):

   - Local overrides for environment variables
   - Not tracked in Git

### VS Code Tasks

The project includes predefined VS Code tasks:

1. **Git Tasks**:

   - `Git: Sync Configuration`: Syncs Git settings
   - `Git: Update User Info`: Updates Git user details
   - `Git: Configure Editor`: Sets up Git editor preferences

2. **Testing Tasks**:

   - `Test: Run All`: Runs all tests
   - `Test: Pre-commit`: Runs pre-commit hooks
   - `Test: Markdown`: Runs markdown tests
   - `Test: Ansible`: Runs Ansible tests

3. **Development Tasks**:

   - `Dev: Rebuild Container`: Rebuilds the devcontainer
   - `Dev: Clean Up`: Cleans up Docker resources
   - `Dev: Update Extensions`: Updates VS Code extensions
