# Rule: Version Control Standards

## Description

All project versions must follow semantic versioning (MAJOR.MINOR.PATCH) and
maintain a clear changelog.

## Structure

### Version Format

- MAJOR: Breaking changes
- MINOR: New features, backward compatible
- PATCH: Bug fixes, backward compatible

### Changelog Requirements

- Each version must have a changelog entry
- Group changes by type (Added, Changed, Fixed)
- Reference related issues/PRs

## Examples

Good version and changelog:

```text
## [1.2.3] - 2024-03-21
### Added
- OAuth2 authentication support (#123)

### Fixed
- Null pointer in user service (#124)
```

Bad version and changelog:

```text
Updated stuff - March 21
- fixed some bugs
- added new features
```

## Enforcement

- Version tags must follow SemVer
- Changelog must be updated with each release
- CI/CD should verify version format
