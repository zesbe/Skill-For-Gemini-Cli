---
name: incremental-refactoring
description: Use when cleaning up legacy code or restructuring complex logic - applies safe, small refactoring steps (Strangler Fig pattern) to improve quality without breaking functionality.
---

# Incremental Refactoring

## Overview

Refactoring is improving the design of existing code without changing its behavior.

**Core Principle:** Don't rewrite. Refactor.

## The Golden Rules

1.  **Tests First:** Never refactor code that doesn't have tests. If tests are missing, write a "Characterization Test" (snapshot test) first to lock in current behavior.
2.  **Small Steps:** Make one small change at a time.
3.  **Green State:** The code must compile and pass tests after *every single step*.

## Common Techniques

### 1. Rename Variable/Method
The simplest and most powerful refactor.
- **Bad:** `d`, `temp`, `doIt()`
- **Good:** `daysSinceCreation`, `tempFile`, `processPayment()`

### 2. Extract Method
Long function? Break it down.
- Select a block of code that does one thing.
- Move it to a new private function.
- Name the function based on *what* it does, not *how* it does it.

### 3. Strangler Fig Pattern (For Rewrites)
Don't delete the old system. Build the new one alongside it.

1. Create `NewProcessor`.
2. In the `OldProcessor`, start delegating one small task to `NewProcessor`.
3. Verify both work.
4. Gradually move more tasks.
5. Once `OldProcessor` is empty, delete it.

## The Loop

1. **Verify:** Run tests (All Green).
2. **Change:** Apply one small refactor (e.g., Rename).
3. **Verify:** Run tests. Failed? **Revert immediately.** Do not debug refactoring.
4. **Commit:** `refactor: rename user to customer`
5. **Repeat.**

## When to Stop
Refactor until:
- The code reads like a sentence.
- Functions fit on one screen.
- There is no duplication.
