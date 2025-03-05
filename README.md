# Ansible Development Environment in Devcontainers

This repository provides a ready-to-use development environment using devcontainers, supporting both Visual Studio Code and Cursor editors. It ensures consistent Git configuration and proper file permissions whether you're working inside the container or on the host machine. It is focused on working with Ansible without installing anything in the local machine.

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

By default, VS Code creates Docker images with auto-generated names. To use custom names:

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

The `launch.sh` script in the root directory will help you start the development environment:

```bash
# Launch your chosen editor (VS Code or Cursor)
./launch.sh
```

The script will:

- Validate your environment configuration
- Check if your chosen editor is installed
- Clean up any existing containers
- Launch the appropriate editor

If there are any issues, the script will provide helpful error messages and instructions.

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

## Git Workflow

This project uses several tools to maintain high code quality and consistent Git practices:

### Repository Synchronization

The repository includes a `sync_git.sh` script to help maintain synchronization with the remote repository. When working inside the devcontainer, you can run it in several ways:

1. From the workspace root (recommended):

   ```bash
   ./scripts/sync_git.sh
   ```

1. Using the absolute path (from any directory):

   ```bash
   /workspace/scripts/sync_git.sh
   ```

1. With force pull option (overwrites local changes):

   ```bash
   FORCE_PULL=true ./scripts/sync_git.sh
   ```

1. With a different branch:

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

1. **Force Pull Mode**:

   - Backs up any local changes
   - Forces sync with remote branch
   - Removes untracked files
   - Use with caution: `FORCE_PULL=true`

1. **Error Handling**:

   - Provides clear error messages
   - Creates backups before destructive operations
   - Guides you through fixing common issues

1. **Safety Features**:

   - Won't overwrite uncommitted changes without FORCE_PULL
   - Creates backups of local changes
   - Validates git configuration before operations

#### Common Use Cases

1. **Initial Setup**:

   ```bash
   cd /workspace
   ./scripts/sync_git.sh
   ```

1. **Daily Updates**:

   ```bash
   # From workspace root
   ./scripts/sync_git.sh
   ```

1. **Discarding Local Changes**:

   ```bash
   # Will backup changes first
   FORCE_PULL=true ./scripts/sync_git.sh
   ```

1. **Working with Feature Branches**:

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

1. **Wrong Branch**:

   ```bash
   # Specify the correct branch:
   BRANCH=main ./scripts/sync_git.sh
   ```

1. **No Remote URL**:

   ```bash
   # Set up your remote first:
   git remote add origin <your-repository-url>
   ./scripts/sync_git.sh
   ```

### Commit Message Format

We follow the [Conventional Commits](https://www.conventionalcommits.org/) specification for commit messages. Each commit message should be structured as follows:

```text
<type>(<scope>): <description>

[optional body]

[optional footer(s)]
```

#### Types

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

The scope should be the name of the component affected (e.g., ansible, git, docker).

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

For breaking changes, add `BREAKING CHANGE:` in the footer and append `!` after the scope:

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

### 4. Git Setup Checklist

✓ Git installation:

- Git command works
- Correct version is installed
- Configuration is properly set

✓ Basic operations:

- File staging works
- Commits are created correctly
- Status shows changes accurately
- Log shows commit history

✓ Permissions:

- Files can be created/deleted

## Testing Ansible Setup

To verify that Ansible is working correctly in your container, follow these steps:

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

For detailed workspace organization rules, see `.cursor/rules/workspace-organization.md`.
