---
name: conventional-commits
description: Use when creating git commits or pull requests - enforces a structured commit message format (Conventional Commits) to ensure history is readable and semantic.
---

# Conventional Commits

## Overview

A commit message should describe **what** changed and **why**, in a format that machines can parse and humans can read.

**Format:**
```
<type>(<scope>): <description>

[optional body]

[optional footer(s)]
```

## The Types

You MUST use one of these prefixes:

- **`feat:`** A new feature (correlates with MINOR release).
- **`fix:`** A bug fix (correlates with PATCH release).
- **`docs:`** Documentation only changes (README, comments).
- **`style:`** Changes that do not affect the meaning of the code (white-space, formatting, missing semi-colons, etc).
- **`refactor:`** A code change that neither fixes a bug nor adds a feature.
- **`perf:`** A code change that improves performance.
- **`test:`** Adding missing tests or correcting existing tests.
- **`chore:`** Changes to the build process or auxiliary tools and libraries.

## Rules

1. **Imperative Mood:** Use "Add" not "Added", "Fix" not "Fixed".
2. **Lowercase:** The description should start with lowercase (unless it's a proper noun).
3. **No Dot:** Do not end the subject line with a period.
4. **Scope:** Optional, but useful. E.g., `feat(auth): add google login`.

## Examples

**Good:**
- `feat(ui): add dark mode toggle`
- `fix(api): handle timeout on slow connections`
- `docs: update installation instructions`
- `refactor: simplify user validation logic`

**Bad:**
- `Fixed the bug` (Vague, wrong tense)
- `update file` (Useless)
- `added new feature` (Vague)

## Workflow

When the user asks to "commit", "save", or "push":
1. Analyze the changes (`git diff --staged` or `git status`).
2. Determine the primary Type (`feat`, `fix`, etc.).
3. Draft a message following the format.
4. Present the message to the user or use it directly.
