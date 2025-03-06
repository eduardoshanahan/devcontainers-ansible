# .cursor Directory

This directory contains Cursor-specific configurations and rules for the
project.

## Directory Structure

```
.cursor/
├── README.md           # This file
├── rules/             # Directory containing all Cursor rules
│   ├── rule-storage.md       # Defines how rules should be stored
│   └── project-settings.md   # Project-wide Cursor settings
```

## Purpose

The `.cursor` directory serves as a central location for all Cursor-specific
configurations and rules. This ensures:

1. Clear separation of Cursor configurations from other project files
2. Consistent location for all Cursor-related settings
3. Easy discovery of project rules and standards
4. Version control of Cursor configurations

## Rules Directory

The `rules/` directory contains individual markdown files, each defining a
specific rule or set of rules for the project. Each rule file follows a
standardized format as defined in `rules/rule-storage.md`.

### Current Rules

1. `rule-storage.md`

   - Defines the standard format for storing rules
   - Specifies naming conventions
   - Details required sections and structure

2. `project-settings.md`

   - Contains project-wide Cursor settings
   - Defines formatting and linting configurations
   - Specifies file watching patterns

## Adding New Rules

To add a new rule:

1. Create a new markdown file in the `rules/` directory
2. Follow the naming convention defined in `rule-storage.md`
3. Use the standard rule format
4. Update this README if the rule introduces new concepts or categories

## Maintenance

- Rules should be reviewed and updated as needed
- Keep this README in sync with the actual contents of the directory
- Ensure all rules are properly categorized and documented
