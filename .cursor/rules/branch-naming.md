# Rule: Branch Naming Conventions

## Description

All Git branches must follow a consistent naming pattern to maintain clarity and
organization in the repository.

## Structure

Format: <type>/<description>

Types:

- feature: New features
- fix: Bug fixes
- hotfix: Urgent fixes for production
- docs: Documentation updates
- refactor: Code restructuring
- test: Test additions or modifications

Description:

- Use kebab-case
- Be concise but descriptive
- Include issue/ticket number if applicable

## Examples

Good branch names:

```text
feature/oauth-login
fix/null-pointer-issue-123
docs/update-deployment-guide
```

Bad branch names:

```text
new-stuff
quick-fix
john-branch
```

## Enforcement

- Pre-commit hooks should validate branch names
- CI/CD pipelines should verify branch naming
- PR creation should check branch name format
