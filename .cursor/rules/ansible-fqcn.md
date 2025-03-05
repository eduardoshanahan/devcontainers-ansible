# Ansible FQCN Usage Rule

## Overview

This rule enforces the use of Fully Qualified Collection Names (FQCN) in Ansible
files to ensure better compatibility, maintainability, and clarity in playbooks
and roles.

## Rule Details

### Required FQCN Format

All Ansible module calls must use their fully qualified collection name. For
example:

✅ **Correct Usage**:

```yaml
- name: Debug message
  ansible.builtin.debug:
    msg: "Hello World"

- name: Copy file
  ansible.builtin.copy:
    src: file.txt
    dest: /tmp/file.txt

- name: Install package
  ansible.builtin.apt:
    name: nginx
    state: present
```

❌ **Incorrect Usage**:

```yaml
- name: Debug message
  debug:
    msg: "Hello World"

- name: Copy file
  copy:
    src: file.txt
    dest: /tmp/file.txt

- name: Install package
  apt:
    name: nginx
    state: present
```

### Common FQCN Prefixes

1. **Built-in Modules**: `ansible.builtin.*`

   - `ansible.builtin.debug`
   - `ansible.builtin.copy`
   - `ansible.builtin.template`
   - `ansible.builtin.file`
   - `ansible.builtin.service`

2. **Community Modules**: `community.*`

   - `community.general.*`
   - `community.docker.*`
   - `community.aws.*`

3. **Legacy Support**: `ansible.legacy.*`

   - Use only when required for backward compatibility

## Implementation

### File Patterns

This rule applies to:

- `*.yml` and `*.yaml` files in:
  - `src/playbooks/`
  - `src/roles/*/tasks/`
  - `src/roles/*/handlers/`
  - `src/roles/*/defaults/`
  - `src/roles/*/vars/`

### Linting

Use `ansible-lint` with the following configuration:

```yaml
enable_list:
  - fqcn-builtins
warn_list:
  - no-free-form
```

## Benefits

1. **Clarity**: Explicit indication of module origin
2. **Maintainability**: Easier to track module sources
3. **Compatibility**: Better handling of module name conflicts
4. **Future-proofing**: Prepared for Ansible updates

## Exceptions

1. Special keywords like `block`, `always`, `rescue` don't require FQCN
2. Role names in `roles:` section don't require FQCN
3. Legacy roles that explicitly require non-FQCN format (document these cases)

## Migration

When updating existing code:

1. Use `ansible-lint` to identify non-FQCN usage
2. Replace short module names with their FQCN equivalents
3. Test playbooks after conversion
4. Document any exceptions in role documentation
