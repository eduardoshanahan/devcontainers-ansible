# Workspace Organization

## Rule

The workspace must follow a standardized directory structure to ensure
consistency and maintainability.

## Details

### Root Directory Structure

```
/workspace/
├── .github/              # GitHub specific files (workflows, templates)
├── .devcontainer/        # Development container configuration
├── .vscode/             # VS Code settings and configurations
├── .cursor/             # Cursor-specific rules and configurations
├── config/              # Configuration files
│   └── ansible/         # Ansible-specific configurations
├── scripts/             # Shell scripts and utilities
├── src/                 # Source code
│   ├── inventory/       # Ansible inventory files
│   ├── playbooks/       # Ansible playbooks
│   └── roles/          # Ansible roles
└── tests/              # Test files and test configurations
```

### File Placement Rules

1. **Configuration Files**

   - All configuration files should be in the `config` directory
   - Language/tool-specific configs go in subdirectories
   - Exceptions: Git-related files (`.gitignore`, `.gitattributes`) stay in root

2. **Scripts**

   - All shell scripts must be in the `scripts` directory
   - Must have executable permissions
   - Must include shebang line
   - Must be documented in README.md

3. **Source Code**

   - All Ansible code must be in `src` directory
   - Organized by type (inventory, playbooks, roles)
   - Follow Ansible best practices for structure

4. **Documentation**

   - README.md stays in root
   - Component-specific documentation goes with the component
   - API documentation goes in `docs` directory (if needed)

### Naming Conventions

1. **Directories**

   - Use lowercase
   - Use hyphens for multi-word names
   - Be descriptive and clear

2. **Files**

   - Use lowercase
   - Use hyphens for multi-word names
   - Use appropriate extensions
   - Be descriptive and clear

### Examples

Good:

```
scripts/sync-git.sh
config/ansible/ansible.cfg
src/playbooks/site.yml
```

Bad:

```
SyncGit.sh
ansible_config.cfg
site_playbook.yml
```
