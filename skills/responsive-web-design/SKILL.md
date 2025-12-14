---
name: responsive-web-design
description: Use when building or styling web user interfaces - enforces Mobile-First approach, modern CSS (Flexbox/Grid), and ensures layout works on all screen sizes (Phone, Tablet, Desktop).
---

# Responsive Web Design

## Overview

A website that only looks good on a laptop is broken.

**Core Principle:** Mobile First. Start small, expand up.

## The Checklist

### 1. The Meta Tag
Every HTML file MUST have this tag in `<head>`:
```html
<meta name="viewport" content="width=device-width, initial-scale=1.0">
```
Without this, mobile browsers will zoom out and break the layout.

### 2. Mobile-First CSS
Write the CSS for the **smallest screen** (phone) first. Use `@media (min-width)` to override for larger screens.

**Bad (Desktop First):**
```css
.container { width: 1000px; }
@media (max-width: 600px) { .container { width: 100%; } }
```

**Good (Mobile First):**
```css
.container { width: 100%; padding: 1rem; }
@media (min-width: 768px) { .container { max-width: 720px; margin: 0 auto; } }
@media (min-width: 1024px) { .container { max-width: 960px; } }
```

### 3. Layout Engines (Flexbox & Grid)
Stop using `float`.
- **Flexbox:** For 1D layouts (Navbar, centering items, lists).
- **Grid:** For 2D layouts (Page structure, Galleries).

**Centering Trick:**
```css
.center-me {
  display: flex;
  justify-content: center;
  align-items: center;
}
```

### 4. Units
- Avoid fixed pixels (`px`) for layout widths. Use `%`, `rem`, `vw/vh`.
- Use `rem` for font sizes (respects user settings).

### 5. Images
Images must never overflow their container.
```css
img, video {
  max-width: 100%;
  height: auto;
}
```

## Testing Breakpoints
Check your design against these standard ranges:
- **Mobile:** < 640px
- **Tablet:** 640px - 1024px
- **Desktop:** > 1024px

## Frameworks
If using Tailwind CSS (Recommended), use prefixes:
- `w-full` (Mobile default)
- `md:w-1/2` (Tablet)
- `lg:w-1/3` (Desktop)
