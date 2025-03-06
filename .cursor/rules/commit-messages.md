# Rule: Git Commit Messages

## Description

All commit messages must follow a consistent format to maintain a clear and
useful git history.

## Structure

Format: <type>(<scope>): <subject>

Types:

- feat: New feature
- fix: Bug fix
- docs: Documentation changes
- style: Code style changes
- refactor: Code refactoring
- test: Adding/modifying tests
- chore: Maintenance tasks

## Examples

Good:

```text
feat(auth): add OAuth2 authentication
fix(api): handle null response from server
docs(readme): update installation steps
```

Bad:

```text
updated stuff
fixed bug
wip
```

## Enforcement

- Pre-commit hooks should validate message format
- PR titles should follow the same convention
- Squashed commits should maintain meaningful messages
