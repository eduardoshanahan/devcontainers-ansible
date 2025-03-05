---
title: Markdown Format Test
description: Test file for markdown formatting rules
---

# Incorrect Header Spacing

This line is too long and should be wrapped because it exceeds the maximum line
length of 80 characters that we have set in our configuration file.

## Nested Headers

### Need Spaces

#### And Lines Between

1. First item
2. Should be numbered as 2
3. Should be numbered as 3
   - Inconsistent bullet
   - Another inconsistent bullet
   - Correct bullet but mixed

```
Code block without language specification
```

```python
# Code block with correct specification
def example():
    return True
```

- Inconsistent

- list

- markers

- [x] Correct task list

- [ ] With proper spacing -\[x\] Incorrect task list spacing

| Column 1 | Column 2 | Column 3 |
| -------- | -------- | -------- |
| No       | Space    | Around   |
| Table    | Cells    | Here     |

> Blockquote without space And incorrect continuation

> Correct blockquote With proper continuation

[link with no space](https://example.com)

[link with correct spacing](https://example.com)

~~Strikethrough with no space~~

~~Strikethrough with correct spacing~~

*Italic with no space*

*Italic with correct spacing*

**Bold with no space**

**Bold with correct spacing**

- List item with_underscore_spacing
- List item with *correct* spacing

1. Ordered list

- Wrong indentation
  - Too many spaces

1. Ordered list
   - Correct indentation
     - Proper nesting
