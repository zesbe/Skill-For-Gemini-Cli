---
name: accessibility-first
description: Use when writing HTML/JSX structure - ensures semantic markup, keyboard navigability, and screen reader support (A11y).
---

# Accessibility First (A11y)

## Overview

The web is for everyone. If you can't use it without a mouse, it's broken.

**Core Principle:** Semantic HTML is 90% of accessibility.

## The Checklist

### 1. Semantic Tags
Don't use `<div>` for everything.
- **Header:** `<header>` not `<div class="header">`
- **Navigation:** `<nav>`
- **Main Content:** `<main>`
- **Button:** `<button>` (Not `<div onclick="...">`)
- **Link:** `<a href="...">` (Not `<span onclick="goto()">`)

### 2. Images
Every `<img>` tag MUST have an `alt` attribute.
- **Informative:** `alt="Graph showing 50% increase"`
- **Decorative:** `alt=""` (Empty string tells screen readers to skip)

### 3. Forms
Every `<input>` MUST have a label.
**Good:**
```html
<label for="email">Email Address</label>
<input id="email" type="email" autocomplete="email">
```

### 4. Keyboard Navigation
- Can you Tab through the site?
- Does the active element have a visible focus ring? (Never do `outline: none` without replacement).

### 5. Color Contrast
Ensure text is readable against the background. Low contrast text is unreadable for many users.

## ARIA (When Semantic Fails)
Use ARIA attributes only when standard HTML tags aren't enough (e.g., custom dropdowns).
- `aria-label="Close menu"`
- `aria-expanded="true"`
