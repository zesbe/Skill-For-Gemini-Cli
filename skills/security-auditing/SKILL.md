---
name: security-auditing
description: Use before committing code or finalizing features - a systematic checklist to identify common vulnerabilities like hardcoded secrets, injection flaws, and insecure dependencies.
---

# Security Auditing Checklist

## Overview

Functionality is not enough. Code must be secure by design.

**Core Principle:** Trust no input, leak no secrets, grant least privilege.

**When to Use:**
- Before any commit involving sensitive data.
- When processing user input.
- When adding new libraries/dependencies.
- When modifying authentication or authorization logic.

## The Audit Checklist

### 1. Secrets & Credentials (CRITICAL)
**Never commit secrets to git.**

- [ ] **Scan:** Look for API keys, passwords, tokens, or private keys in the code.
- [ ] **Move:** Extract them to Environment Variables (`.env`) or a secure vault.
- [ ] **Gitignore:** Ensure `.env`, `*.key`, `*.pem`, and config files with secrets are in `.gitignore`.
- [ ] **History:** If a secret was committed, it is compromised. Rotate it immediately.

### 2. Input Validation (Injection Prevention)
**All input is evil until proven otherwise.**

- [ ] **Sanitize:** Escape all user input before rendering (prevents XSS).
- [ ] **Parameterize:** Use parameterized queries for SQL (prevents SQL Injection). NEVER concatenate strings into queries.
- [ ] **Validate:** Enforce strict type, length, and format checks on all inputs (API params, CLI args).
- [ ] **Path Traversal:** If reading files based on input, ensure user can't access `../../etc/passwd`.

### 3. Dependencies (Supply Chain)
**Know what you import.**

- [ ] **Vetted:** Use popular, maintained packages. Avoid abandoned libraries.
- [ ] **Minimal:** Don't import a huge library just for one function.
- [ ] **Locked:** Use lockfiles (`package-lock.json`, `go.sum`, `Cargo.lock`) to ensure version consistency.

### 4. Least Privilege & Data Exposure
**Limit the blast radius.**

- [ ] **Permissions:** Does the script need root/sudo? If not, don't ask for it.
- [ ] **Logging:** Do not log sensitive data (PII, tokens, passwords) to stdout/files.
- [ ] **Error Handling:** Don't expose stack traces to end-users (it reveals system info). Fail gracefully.

## Auto-Fix Patterns

**Bad (Hardcoded Secret):**
```python
api_key = "sk-1234567890" # DANGER
connect_to_api(api_key)
```

**Good (Environment Variable):**
```python
import os
api_key = os.getenv("API_KEY")
if not api_key:
    raise ValueError("API_KEY environment variable not set")
connect_to_api(api_key)
```

**Bad (Shell Injection):**
```javascript
// DANGER: User can pass "; rm -rf /"
exec(`ping ${userInput}`);
```

**Good (Sanitized/Array args):**
```javascript
// Safe: Arguments passed as array
execFile('ping', [userInput]);
```

## Final Verification
If you find a violation:
1. **Stop.** Do not proceed with the task.
2. **Fix** the security issue immediately.
3. **Verify** the fix (try to exploit it yourself if safe).
4. Continue with the original task.
