---
name: spring-redis
description: Add or review Redis in Spring Boot for application caching, cache invalidation, token/session state, lightweight distributed coordination, TTL and key design. Redis is opt-in; use only when the task explicitly benefits from Redis.
---

# Spring Redis

## Canonical reference

Read:

`../../../references/skill-pack/REDIS.md`

## Rule

Do not add Redis to a project simply because this skill exists.

First state what problem Redis solves:

- expensive repeated reads;
- cross-instance shared ephemeral state;
- rate-limit/counter use case;
- token/session state;
- distributed coordination with understood failure semantics.

## Workflow

1. Define source of truth.
2. Define key format.
3. Define TTL.
4. Define invalidation/refresh behavior.
5. Define behavior when Redis is unavailable.
6. Define serialization compatibility.
7. Add metrics/logging for cache effectiveness where useful.
8. Test stale/miss/unavailable paths.

For ordinary JPA query performance, optimize the database/query first.
