---
name: api-design-rest-graphql
description: Use when designing backend APIs - enforces RESTful standards (resource-based URLs, correct HTTP verbs/codes) or GraphQL best practices.
---

# API Design Standards

## Overview

An API is a contract. Don't break it.

## REST Best Practices

### 1. Resource Naming
Use **Plural Nouns**.
- **Good:** `/users`, `/users/123/orders`
- **Bad:** `/getUser`, `/createOrder`, `/users/list`

### 2. HTTP Methods (Verbs)
- **GET:** Read (Safe, Cacheable).
- **POST:** Create (Not idempotent).
- **PUT:** Replace/Update (Idempotent).
- **PATCH:** Partial Update.
- **DELETE:** Remove.

### 3. Status Codes
Stop returning 200 for errors.

- **200:** OK.
- **201:** Created (Return the new resource URL in Location header).
- **204:** No Content (Good for DELETE).
- **400:** Bad Request (Validation error).
- **401:** Unauthorized (Not logged in).
- **403:** Forbidden (Logged in, but no permission).
- **404:** Not Found.
- **500:** Server Error (Your fault).

### 4. Response Structure
Be consistent.

**Success:**
```json
{
  "data": { "id": 1, "name": "Alice" }
}
```

**List:**
```json
{
  "data": [...],
  "meta": { "page": 1, "total": 100 }
}
```

**Error:**
```json
{
  "error": {
    "code": "VALIDATION_ERROR",
    "message": "Email is invalid",
    "details": { "field": "email" }
  }
}
```

### 5. Versioning
Always version your API.
- `/api/v1/users`
