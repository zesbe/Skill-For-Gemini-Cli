---
name: cli-best-practices
description: Use when building or refactoring Command Line Interface (CLI) tools - ensures adherence to standard Unix philosophy, proper exit codes, signal handling, and user-friendly output formatting.
---

# CLI Best Practices

## Overview

Building a CLI tool requires more than just making it work. It needs to be a good citizen of the shell environment.

**Core Principle:** Be silent on success, helpful on failure, and predictable in behavior.

## The Checklist

### 1. Exit Codes
**Never exit with 0 on failure.**

- **0:** Success
- **1:** General error
- **2:** Misuse of shell builtins (rarely used by apps)
- **126:** Command invoked cannot execute
- **127:** Command not found
- **130:** Script terminated by Control-C
- **>0:** Custom error codes (document them!)

### 2. Standard Streams
**Know where to print.**

- **stdout (Standard Output):** The *result* of the command (e.g., the processed text, the list of files). This is what gets piped `|` to other commands.
- **stderr (Standard Error):** Logs, status updates, errors, warnings, and interactive prompts. These should *not* pollute the data stream.

**Test:** `my-tool > /dev/null` should still show errors/logs. `my-tool 2> /dev/null` should only show data.

### 3. Argument Parsing
**Don't reinvent the wheel.**

- Support `--help` and `--version`.
- Use standard flags (`-v` for verbose, `-q` for quiet, `-f` for force).
- Use established libraries (e.g., `argparse` in Python, `commander` in Node.js, `cobra` in Go) rather than manual string parsing.

### 4. Signal Handling
**Respect the user's control.**

- Handle `SIGINT` (Ctrl+C): Clean up temp files and exit gracefully immediately.
- Handle `SIGTERM`: Graceful shutdown.

### 5. Interactivity
**Don't assume a human is watching.**

- Check if `stdout` is a TTY before printing colors or progress bars.
- Disable interactivity if input is piped (`|`) or redirected (`<`).
- Provide a `--no-interactive` or `--yes` flag for scripts.

### 6. Configuration
**Follow the hierarchy.**

1. **Command Line Arguments** (Highest priority)
2. **Environment Variables**
3. **Local Config File** (`./.config`)
4. **User Config File** (`~/.config/mytool/config`)
5. **Defaults** (Lowest priority)

## Anti-Patterns

- **Printing "Success!" to stdout:** If the user pipes the output to a file, "Success!" will corrupt the data. Print it to stderr.
- **Asking for confirmation without a bypass flag:** Breaks automation scripts.
- **Swallowing errors:** Always exit with non-zero if the job wasn't done.
- **Hardcoding paths:** Use relative paths or environment variables (`$HOME`, `$TMPDIR`).

## Template (Bash)

```bash
#!/bin/bash

set -e  # Exit on error
set -u  # Exit on undefined variable
set -o pipefail # Exit if pipe fails

usage() {
  echo "Usage: $0 [options] <input>" >&2
  echo "  -h, --help    Show this help" >&2
  exit 1
}

main() {
  if [ $# -eq 0 ]; then
    usage
  fi
  
  # Logic here
  echo "Processing $1..." >&2 # Log to stderr
  
  # Result to stdout
  echo "Result Data"
}

main "$@"
```
