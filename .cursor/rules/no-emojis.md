# Rule: No Emojis in Markdown

## Description

Emojis should not be used in markdown files within the project. This ensures
consistency in documentation, improves readability, and prevents potential
rendering issues across different platforms and markdown viewers.

## Structure

All markdown files (`.md`) in the project should:

- Use plain text and standard markdown syntax
- Use appropriate formatting (headers, lists, code blocks, etc.) for emphasis
- Avoid emoji characters and emoji shortcodes

## Examples

Good markdown:

```text
# Welcome to Our Project
This is a great feature that improves performance.

**Important:** Please review the documentation carefully.
```

Bad markdown:

```text
# 👋 Welcome to Our Project
This is a great feature that improves performance! 🚀

⚠️ **Important:** Please review the documentation carefully ✨
```

## Enforcement

- No Unicode emoji characters should be present in markdown files
- No GitHub-style emoji shortcodes (e.g., `:smile:`, `:rocket:`)
- This applies to all markdown files including:
  - Documentation
  - README files
  - Cursor rules
  - Pull request templates
  - Issue templates
