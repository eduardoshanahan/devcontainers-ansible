# Rule: Code Review Standards

## Description

All code changes must go through a standardized review process to maintain code
quality and knowledge sharing.

## Structure

### Review Requirements

- At least one approved review before merge
- All CI checks must pass
- No unresolved comments
- All conversations must be resolved

### Review Focus Areas

- Code correctness
- Test coverage
- Documentation updates
- Security considerations
- Performance implications

## Examples

Good review comment:

```text
The null check here might miss edge cases where the input is an empty string.
Consider using `if (input == null || input.trim().isEmpty())`
```

Bad review comment:

```text
This looks wrong
```

## Enforcement

- Branch protection rules
- Required reviewers
- Automated checks in CI pipeline
- Review template compliance
