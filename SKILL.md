---
name: dr-jskill
description: Compatibility umbrella for the modular Dr JSkill pack. Use when an assistant supports a single root skill but not repo-local multi-skill discovery. Route Spring Boot work to the specialized skills under .agents/skills when those skills are available.
---

# Dr JSkill compatibility umbrella

This repository now uses multiple focused skills under `.agents/skills/`.

## Route first

Prefer the specialized skill that matches the task:

| Concern | Skill |
|---|---|
| bootstrap/project/config | `spring-project` |
| JPA/PostgreSQL | `spring-data-jpa` |
| authentication/authorization | `spring-security` |
| unit/integration tests | `spring-testing` |
| Angular/React/Vue/Vanilla | `spring-frontend` |
| Docker/AOT/native/CRaC | `spring-container` |
| Azure/deployment | `spring-deployment` |
| Redis | `spring-redis` |
| Elasticsearch | `spring-elasticsearch` |

If the host cannot discover nested skills, use this file as the router and then read the target `.agents/skills/<name>/SKILL.md`.

## Shared resources

Do not load every reference up front.

Canonical knowledge remains under root `references/`.
Generator automation remains under root `scripts/`.
Templates remain under root `assets/`.
Versions remain in root `versions.json`.

## Core invariants

- Java 25 + Spring Boot 4.x baseline.
- Maven by default.
- PostgreSQL default persistent database.
- Frontend is optional and may be Angular, React, Vue or Vanilla JS.
- Redis and Elasticsearch are opt-in, not baseline dependencies.
- Never expose `.env`.
- Validate generated/modified projects before finishing.

Read `AGENTS.md` for repository-wide rules and `SKILLS.md` for the human-readable catalog.
