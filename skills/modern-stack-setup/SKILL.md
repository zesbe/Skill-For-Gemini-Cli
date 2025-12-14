---
name: modern-stack-setup
description: Use when initializing new web projects - recommends and configures modern, high-performance tools (Vite, Next.js, Tailwind) instead of legacy ones (CRA, Webpack manual config).
---

# Modern Stack Setup

## Overview

Start fast. Use tools that scale.

**Core Principle:** Configuration should be minimal. Performance should be default.

## Recommendations

### 1. Frontend Frameworks
**Do not use:** `create-react-app` (Deprecated/Slow).

- **For Single Page Apps (SPA):** Use **Vite**.
  ```bash
  npm create vite@latest my-app -- --template react-ts
  ```
- **For Fullstack/SSR:** Use **Next.js**.
  ```bash
  npx create-next-app@latest
  ```

### 2. Styling
**Do not use:** Raw CSS files with manual BEM naming (unless requested).

- **Recommended:** **Tailwind CSS**.
  It enforces consistency, reduces CSS bundle size, and speeds up dev.

### 3. Language
**Do not use:** Plain JavaScript for large projects.

- **Recommended:** **TypeScript**.
  It catches bugs at compile time.

### 4. Code Quality
Always initialize with:
- **Prettier:** For formatting.
- **ESLint:** For catching errors.

## Quick Start Template (Vite + React + TS + Tailwind)

If the user asks for a "React App":

1. `npm create vite@latest . -- --template react-ts`
2. `npm install -D tailwindcss postcss autoprefixer`
3. `npx tailwindcss init -p`
4. Setup `tailwind.config.js` content paths.
5. Add directives to `index.css`.

This setup takes < 1 minute and is 100x faster than CRA.
