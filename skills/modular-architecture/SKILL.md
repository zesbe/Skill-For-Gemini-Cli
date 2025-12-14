---
name: modular-architecture
description: Use when starting a new project or restructuring a large one - enforces Separation of Concerns, Single Responsibility Principle, and clean folder structures.
---

# Modular Architecture

## Overview

Avoid "God Objects" and "Spaghetti Code". Break systems into small, independent modules.

**Core Principle:** High Cohesion, Low Coupling.

## The Principles

### 1. Single Responsibility Principle (SRP)
A file/class/function should have **one and only one reason to change**.
- **Bad:** `UserManager` handles database, email sending, and logging.
- **Good:** `UserRepository` (DB), `EmailService` (Email), `Logger` (Log).

### 2. Separation of Concerns
Keep layers distinct.
- **Presentation Layer:** CLI, API Routes, UI (Handles Input/Output).
- **Business Logic Layer:** Services, Core Logic (Handles Rules).
- **Data Access Layer:** SQL Queries, File I/O (Handles Storage).

*Rule:* The Business Logic should never know about HTTP requests or SQL commands directly.

### 3. Folder Structure (Standard)

Don't dump everything in root.

**Example (Node/Python/Go):**
```
src/
  ├── config/         # Environment vars, setup
  ├── controllers/    # Route handlers / CLI commands
  ├── services/       # Business logic (The "Brain")
  ├── models/         # Database schemas / Types
  ├── utils/          # Helper functions (Date format, etc.)
  ├── app.js          # Entry point
  └── ...
```

## Anti-Patterns

- **Circular Dependencies:** A imports B, B imports A. (Fix: Extract shared logic to C).
- **God Classes:** `Main.java` or `utils.js` that has 5000 lines.
- **Hard Dependencies:** `new Database()` inside a Service. (Fix: Use Dependency Injection).

## Checklist for New Features

- [ ] Does this belong in an existing file, or does it need a new module?
- [ ] Can I test this logic without mocking the entire database?
- [ ] Is the business logic separated from the framework code?
