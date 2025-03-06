# Markdown Formatting Standards

## Overview

This document outlines comprehensive standards for creating and formatting
markdown documents in our project. These standards ensure consistency,
readability, and compatibility across all documentation.

## Required Format

### 1. Headers

- Use ATX-style headers (with #)
- Include a blank line before and after headers
- Use proper header hierarchy (h1 -> h2 -> h3)
- Don't skip header levels
- One space after #
- No trailing spaces

### 2. Lists

- Ordered lists must use incrementing numbers (1, 2, 3, ...)
- No repeated numbers in ordered lists
- Unordered lists must use consistent markers (- preferred)
- Include blank lines between list items for better readability
- Proper indentation (4 spaces) for nested lists
- End lists with a blank line

### 3. Code Blocks

- Must specify language after backticks
- Must have empty lines before and after
- Must use consistent indentation
- Common language specifiers:
  - `text` for plain text or directory structures
  - `markdown` for markdown examples
  - `bash` for shell commands
  - `json` for JSON data
  - `yaml` for YAML configurations
  - `python` for Python code
  - `javascript` for JavaScript code

### 4. Line Endings and Spacing

- Must use Unix-style line endings (LF)
- No trailing whitespace
- Files must end with single newline
- Include blank lines between sections
- Consistent spacing around elements

### 5. Links and Images

- Use reference-style links for better readability
- Include alt text for all images
- Use relative paths for internal links

### 6. Tables

- Include header separator row
- Align columns using hyphens
- Include blank lines before and after tables

### 7. Blockquotes

- Use > for blockquotes
- Include blank lines before and after blockquotes
- Use > for each line in multi-line blockquotes

### 8. Emphasis

- Use \*\* for strong emphasis
- Use * for emphasis
- Use \` for code or technical terms

### 9. Horizontal Rules

- Use three or more hyphens (---)
- Include blank lines before and after horizontal rules

## Examples

### ✅ Correct Usage

````markdown
# Header

This is a paragraph.

## Subheader

1. First item
2. Second item
    - Nested item
    - Another nested item
3. Third item

## Another Section

```python
def example():
    return True
````

> Blockquote text

````

### ❌ Incorrect Usage

```markdown
#Incorrect Header
This is a paragraph without spacing.
##Subheader
1. First item
1. Second item
* Inconsistent list marker
- Mixed markers
```python
def example():
    return True
```No spacing around code block
````

## Implementation

### File Patterns

This rule applies to:

- `*.md` files
- `*.markdown` files
- Documentation in any directory

### Linting Configuration

```toml
# .mdformat.toml
wrap = 80
number = true
```

### Pre-commit Hook

```yaml
# .pre-commit-config.yaml
- repo: https://github.com/executablebooks/mdformat
  rev: 0.7.17
  hooks:
    - id: mdformat
      additional_dependencies:
        - mdformat-gfm
        - mdformat-frontmatter
        - mdformat-footnote
```

### VS Code Settings

```json
{
  "[markdown]": {
    "editor.defaultFormatter": "executablebooks.mdformat",
    "editor.formatOnSave": true,
    "editor.rulers": [80],
    "files.trimTrailingWhitespace": true,
    "files.insertFinalNewline": true
  }
}
```

## Benefits

1. **Consistency**: Uniform formatting across all documentation
2. **Readability**: Clear structure and hierarchy
3. **Maintainability**: Easier to update and review
4. **Compatibility**: Better rendering across different platforms

## Common Issues and Solutions

1. **Repeated List Numbers**:

   - ❌ Wrong: Multiple `1.` at start
   - ✅ Right: Increment numbers (1, 2, 3)

2. **Missing Spaces**:

   - ❌ Wrong: `#Header`
   - ✅ Right: `# Header`

3. **Inconsistent Indentation**:

   - ❌ Wrong: Mixed spaces/tabs
   - ✅ Right: 4 spaces for nesting

4. **Code Block Format**:

   - ❌ Wrong: No language specified
   - ✅ Right: Include language tag
