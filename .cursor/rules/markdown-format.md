# Markdown Formatting Standards

## Overview

This rule enforces consistent markdown formatting across all documentation files
to ensure readability and pass mdformat checks.

## Rule Details

### Required Format

1. **Lists**:

   - Ordered lists must use incrementing numbers (1, 2, 3, ...)
   - No repeated numbers in ordered lists
   - Unordered lists must use consistent markers (`-` preferred)
   - Proper indentation (4 spaces) for nested lists

2. **Code Blocks**:

   - Must specify language after backticks
   - Must have empty lines before and after
   - Must use consistent indentation

   ```python
   # Example of proper code block
   def example():
       return True
   ```

3. **Headers**:

   - Must have empty line before and after
   - Use ATX-style headers (`#`) only
   - One space after `#`
   - No trailing spaces

4. **Line Endings**:

   - Must use Unix-style line endings (LF)
   - No trailing whitespace
   - Files must end with single newline

### Examples

✅ **Correct Usage**:

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

````

❌ **Incorrect Usage**:

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

### Linting

Use mdformat with the following configuration:

```toml
# .mdformat.toml
wrap = 80
number = true
```

## Benefits

1. **Consistency**: Uniform formatting across all documentation
2. **Readability**: Clear structure and hierarchy
3. **Maintainability**: Easier to update and review
4. **Compatibility**: Better rendering across different platforms

## Enforcement

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
