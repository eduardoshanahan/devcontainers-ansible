# Contributing Guidelines

Thank you for your interest in contributing to our Ansible project! This document provides guidelines and steps for contributing.

## Getting Started

1. Fork the repository
2. Clone your fork:
   ```bash
   git clone https://github.com/YOUR-USERNAME/REPOSITORY-NAME.git
   ```
3. Set up your development environment:
   ```bash
   ./launch_vscode.sh
   ```

## Development Workflow

1. Create a new branch for your feature:
   ```bash
   git checkout -b feature/your-feature-name
   ```

2. Install pre-commit hooks:
   ```bash
   pre-commit install
   ```

3. Make your changes following these guidelines:
   - Follow [Ansible best practices](https://docs.ansible.com/ansible/latest/tips_tricks/ansible_tips_tricks.html)
   - Write clear, descriptive commit messages
   - Include tests for new functionality
   - Update documentation as needed

4. Test your changes:
   - Run molecule tests for roles
   - Run ansible-lint
   - Run yamllint
   - Verify playbook syntax

5. Push changes and create a Pull Request:
   ```bash
   git push origin feature/your-feature-name
   ```

## Code Style

- Use YAML files with `.yml` extension
- Use 2 spaces for indentation
- Follow [Ansible YAML syntax](https://docs.ansible.com/ansible/latest/reference_appendices/YAMLSyntax.html)
- Use Fully Qualified Collection Names (FQCN)
- Keep lines under 160 characters
- Use meaningful variable names

## Testing

### Molecule Tests
```bash
cd roles/your-role
molecule test
```

### Linting
```bash
ansible-lint
yamllint .
```

## Documentation

- Update README.md with new features
- Document role variables in role/defaults/main.yml
- Include examples in role/README.md
- Update inventory documentation

## Security

- Never commit sensitive data
- Use ansible-vault for secrets
- Review code for security implications
- Follow principle of least privilege
- Use secure protocols (SSH, HTTPS)

## Pull Request Process

1. Update documentation
2. Pass all tests and checks
3. Get approval from maintainers
4. Squash commits if requested
5. Ensure CI/CD pipeline passes

## Additional Resources

- [Ansible Documentation](https://docs.ansible.com/)
- [Molecule Documentation](https://molecule.readthedocs.io/)
- [Ansible Galaxy](https://galaxy.ansible.com/)
- [Git Commit Messages](https://chris.beams.io/posts/git-commit/)
