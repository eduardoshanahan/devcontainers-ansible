# Rule: Cursor Rules Organization

## Description

All Cursor rules must be stored in the `.cursor/rules` directory, with each rule in its own markdown file.

## Structure

- Each rule file should be in markdown format
- File name should be descriptive and use kebab-case
- Each rule should have the following sections:
  1. Title (H1)
  2. Description
  3. Structure (if applicable)
  4. Examples
  5. Enforcement

## Examples

Good file locations:

```text
.cursor/rules/code-style.md
.cursor/rules/documentation.md
.cursor/rules/testing.md
```

Bad file locations:

```text
rules/cursor-rules.md
.vscode/cursor-rules.md
cursor-rules.md
```

## Enforcement

- All new rules must be added to `.cursor/rules/`
- Each rule should be in its own file
- Rule files must follow the structure outlined above
- Rule files must use `.md` extension
