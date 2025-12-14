---
name: documentation-driven-development
description: Use when adding new features, APIs, or tools - ensures that documentation (README, JSDoc, Docstrings) is updated continuously alongside the code, not after.
---

# Documentation Driven Development (DDD)

## Overview

Code that isn't documented doesn't exist to the user.

**Core Principle:** Update the instructions *before* or *while* you write the code.

## When to Use

- Adding a new feature.
- Changing an existing API/function signature.
- Adding a new environment variable.
- Creating a new script or tool.

## The Checklist

### 1. The "Read-Me First" Approach
Before implementing a complex feature, write the **Usage Example** in the README or a comment.

*Why?* It validates the design. If the usage example is hard to explain, the design is bad.

**Example:**
> "I'm going to add a resize image function. Let me update the docs first to see how it looks."

```markdown
## Image Resizing
Use `resize(img, width, height)` to scale images.
```

### 2. Public Interface Documentation
Every public function, class, or endpoint MUST have a docstring/comment explaining:
- **Args:** What goes in? (Type and meaning)
- **Returns:** What comes out?
- **Throws:** What errors can happen?

### 3. Environment Variables
If you add `process.env.API_KEY` to the code, you **MUST** immediately:
- Add it to `.env.example` (with a dummy value).
- Add it to the "Configuration" section of `README.md`.

### 4. Dependencies
If you run `npm install` or `pip install`:
- Update `package.json` / `requirements.txt` immediately.
- Mention requirements in `README.md` if non-standard.

## Red Flags

- "I'll document this later." (You won't).
- "The code is self-documenting." (It's not, especially for users).
- A `README.md` that hasn't been touched in months while code changes daily.
