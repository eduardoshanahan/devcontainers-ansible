# Project Settings

## Rule

Project must maintain a `.cursor-project-rules` file in the root directory with standardized formatting and linting configurations.

## Details

### Configuration File
The `.cursor-project-rules` file must contain:

```json
{
  "name": "devcontainers-ansible",
  "include": [
    "**/*.{yml,yaml,json,md,sh,py,ini}",
    ".devcontainer/**/*",
    ".vscode/**/*"
  ],
  "exclude": [
    "node_modules",
    ".git",
    "__pycache__",
    "*.pyc",
    ".pytest_cache",
    ".env"
  ],
  "formatOnSave": true,
  "lintOnSave": true,
  "defaultFormatter": {
    "yml,yaml": "prettier",
    "json": "prettier",
    "md": "prettier",
    "sh": "shfmt",
    "py": "black"
  }
}
```

### Requirements

1. File Watching
   - Must include all relevant file types for the project
   - Must include configuration directories
   - Must exclude temporary and system files

2. Automation
   - Must enable format on save
   - Must enable lint on save

3. Formatters
   - Must specify default formatters for each file type
   - Must use industry-standard formatters
