# Ansible Development Environment

This repository contains a development environment setup for Ansible using VS Code and Dev Containers.

## Prerequisites

- [Visual Studio Code](https://code.visualstudio.com/)
- [Docker](https://www.docker.com/products/docker-desktop)
- [VS Code Remote Development Extension Pack](https://marketplace.visualstudio.com/items?itemName=ms-vscode-remote.vscode-remote-extensionpack)

## Quick Start

1. Clone this repository:
   ```bash
   git clone <repository-url>
   cd <repository-name>
   ```

2. Set up environment variables:
   ```bash
   cp .devcontainer/.env.example .devcontainer/.env
   ```
   Edit `.devcontainer/.env` with your personal information and Docker preferences.

3. Launch VS Code:
   ```bash
   ./launch_vscode.sh
   ```

## Docker Configuration

The development environment uses a Docker container with the following default settings (configurable in `.devcontainer/.env`):

- Image Name: `ansible-dev`
- Image Tag: `latest`
- Container Name: `ansible-dev-env`

You can customize these settings by editing the `.devcontainer/.env` file:
```bash
DOCKER_IMAGE_NAME=ansible-dev
DOCKER_IMAGE_TAG=latest
DOCKER_CONTAINER_NAME=ansible-dev-env
```

To rebuild the Docker image:
```bash
docker build -t ${DOCKER_IMAGE_NAME}:${DOCKER_IMAGE_TAG} .devcontainer/
```

To run the container manually (though normally handled by VS Code):
```bash
docker run -it --name ${DOCKER_CONTAINER_NAME} ${DOCKER_IMAGE_NAME}:${DOCKER_IMAGE_TAG}
```

## Git Workflow

This project uses several tools to maintain high code quality and consistent Git practices:

### Initial Setup

1. Install pre-commit hooks:
   ```bash
   pip install -r requirements.txt
   pre-commit install --install-hooks
   pre-commit install --hook-type commit-msg
   ```

2. Configure Git:
   ```bash
   git config --local core.autocrlf input
   git config --local core.eol lf
   ```

### Making Changes

1. Create a new branch:
   ```bash
   git checkout -b feature/your-feature-name
   ```

2. Make your changes and stage them:
   ```bash
   git add .
   ```

3. Commit using Commitizen:
   ```bash
   cz commit
   ```
   This will guide you through creating a standardized commit message.

### Commit Message Format

We use Conventional Commits with the following types:
- `feat`: New feature
- `fix`: Bug fix
- `docs`: Documentation changes
- `style`: Code style changes (formatting, etc.)
- `refactor`: Code refactoring
- `perf`: Performance improvements
- `test`: Adding or updating tests
- `build`: Build system changes
- `ci`: CI configuration changes
- `chore`: Other changes

Example:
```
feat(inventory): add support for dynamic AWS hosts

Added AWS dynamic inventory plugin configuration and documentation.
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

### Version Management

1. Generate changelog:
   ```bash
   git-changelog
   ```

2. Bump version:
   ```bash
   cz bump
   ```

### Git Best Practices

1. Keep commits atomic and focused
2. Write descriptive commit messages
3. Reference issues in commits when applicable
4. Keep branches up to date with main
5. Delete branches after merging
6. Use pull requests for code review

### Git Hooks

Pre-commit hooks check for:
- Code formatting
- Linting
- Security issues
- Commit message format
- File formatting
- Line endings

### Troubleshooting

1. If pre-commit hooks fail:
   ```bash
   pre-commit clean
   pre-commit install --install-hooks
   ```

2. To skip hooks temporarily:
   ```bash
   git commit --no-verify
   ```
   (Use sparingly and only when necessary)

3. To update hooks:
   ```bash
   pre-commit autoupdate
   ```

## Environment Variables

Required environment variables in `.devcontainer/.env`:

- `HOST_USERNAME`: Your username
- `HOST_UID`: Your user ID (usually 1000)
- `HOST_GID`: Your group ID (usually 1000)
- `GIT_USER_NAME`: Your Git username
- `GIT_USER_EMAIL`: Your Git email

Optional variables:
- `SSH_AUTH_SOCK`: Path to SSH agent socket
- `ANSIBLE_CONFIG`: Path to ansible.cfg
- `ANSIBLE_VAULT_PASSWORD_FILE`: Path to vault password file

## Directory Structure

```
.
├── .devcontainer/          # Dev container configuration
│   ├── .env.example       # Example environment variables
│   ├── Dockerfile         # Container definition
│   ├── devcontainer.json  # VS Code dev container config
│   └── ssh-agent-setup.sh # SSH agent configuration
├── .vscode/               # VS Code workspace settings
├── src/                   # Source directory
│   ├── inventory/        # Ansible inventory files
│   ├── playbooks/        # Ansible playbooks
│   ├── roles/            # Ansible roles
│   └── ansible.cfg       # Ansible configuration
├── tests/                # Test files
├── requirements.txt      # Python dependencies
└── requirements.yml      # Ansible collections and roles
```

## Available Tasks

Access tasks through VS Code:
1. Press `Ctrl+Shift+P` (or `Cmd+Shift+P` on macOS)
2. Type "Tasks: Run Task"
3. Select from available tasks:

- Install Requirements: Install all Python and Ansible dependencies
- Lint Ansible: Run ansible-lint on playbooks
- Syntax Check: Verify playbook syntax
- Create Vault File: Create new encrypted file
- Edit Vault File: Edit existing encrypted file
- Clean Cache: Remove temporary files

## Features

- Automated development environment setup
- SSH agent forwarding
- Git configuration
- Integrated Ansible linting and validation
- Python development tools
- Consistent code formatting
- Comprehensive VS Code extensions
- Integrated task running
- Vault integration
- Inventory management

## Configuration

### Ansible Configuration

The `ansible.cfg` file includes:
- Inventory settings
- Performance optimizations
- SSH configurations
- Privilege escalation
- Error handling
- Vault settings

### VS Code Settings

Includes configurations for:
- Python development
- Ansible development
- YAML formatting
- Git integration
- Terminal settings
- Editor preferences

## Best Practices

1. Never commit sensitive information
2. Use ansible-vault for secrets
3. Keep inventory files separate
4. Follow Ansible best practices
5. Use version control effectively
6. Regular linting and testing
7. Document your code
8. Use meaningful commit messages

## Development Workflow

1. Create feature branch
2. Make changes
3. Run linting (VS Code Task: "Lint Ansible")
4. Run syntax check (VS Code Task: "Syntax Check")
5. Commit changes
6. Create pull request

To run tasks in VS Code:
1. Press `Ctrl+Shift+P` (or `Cmd+Shift+P` on macOS)
2. Type "Tasks: Run Task"
3. Select the desired task

## Troubleshooting

Common issues and solutions:

1. SSH agent not working:
   - Check SSH_AUTH_SOCK variable
   - Ensure keys are added to agent
   - Verify permissions

2. Container fails to start:
   - Verify Docker is running
   - Check environment variables
   - Check Docker logs

3. VS Code extensions not loading:
   - Rebuild container
   - Check extension marketplace availability
   - Verify internet connection

4. Ansible issues:
   - Check inventory file
   - Verify SSH access
   - Check privilege escalation
   - Review ansible.cfg

## Security

- Use vault for sensitive data
- Regular security updates
- Proper file permissions
- SSH key management
- Secure inventory handling

## Contributing

See [CONTRIBUTING.md](CONTRIBUTING.md) for detailed contribution guidelines.

## License

[MIT License](LICENSE)

## Support

For issues and feature requests, please create an issue in the repository.
