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
   Edit `.devcontainer/.env` with your personal information.

3. Launch VS Code:
   ```bash
   ./launch_vscode.sh
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

1. Fork the repository
2. Create a feature branch
3. Commit changes
4. Push to the branch
5. Create a Pull Request

## License

[MIT License](LICENSE)

## Support

For issues and feature requests, please create an issue in the repository.
