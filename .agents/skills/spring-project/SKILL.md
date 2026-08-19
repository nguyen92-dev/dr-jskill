---
name: spring-project
description: Bootstrap or restructure Spring Boot 4 projects: Java 25, Maven, base dependencies, project layout, configuration, logging, dotfiles, JDTLS, and generator usage. Use for new Spring Boot apps or project-wide setup; do not use as the primary skill for security, deep JPA work, frontend implementation, Redis, Elasticsearch, or deployment.
---

# Spring Project

## Goal

Create or maintain the project foundation without pulling every specialist concern into one context.

## Workflow

1. Inspect `../../../versions.json` before assuming managed versions.
2. For new applications, prefer the existing deterministic generator under `../../../scripts/`.
3. Determine only the inputs needed for generation:
   - project name/group/artifact/package;
   - Java version if different from the repository default;
   - project type;
   - frontend choice if requested;
   - output directory.
4. Read `../../../references/SPRING-BOOT-4.md` when Boot 4 behavior or migration details matter.
5. Read `../../../references/PROJECT-SETUP.md` for dotfiles/devcontainer/project setup.
6. Read `../../../references/CONFIGURATION.md` for Spring configuration/profiles/secrets.
7. Read `../../../references/LOGGING.md` only for logging work.
8. Read `../../../references/JDTLS.md` only for semantic Java tooling/navigation.
9. Read `../../../references/GIT.md` only for Git workflow questions.
10. Hand specialist work to the narrow skill:
    - persistence → `spring-data-jpa`
    - security → `spring-security`
    - tests → `spring-testing`
    - frontend → `spring-frontend`
    - containers → `spring-container`
    - deployment → `spring-deployment`
    - Redis → `spring-redis`
    - Elasticsearch → `spring-elasticsearch`

## Generator

For a new app, inspect the existing launcher/help before inventing commands.

Typical entry point:

```bash
node scripts/create-project-latest.mjs ...
```

Always pass the user's workspace output directory when the generator would otherwise write inside the skill/repository checkout.

## Defaults

- Spring Boot 4.x
- Java 25
- Maven
- PostgreSQL when persistence is needed
- Spring Actuator for production-oriented apps
- `application.properties` unless the existing project intentionally uses YAML
- `spring.jpa.open-in-view=false` for JPA apps
- secrets externalized; never print `.env`

Do not add Spring Security, Redis, Elasticsearch, native images, or a frontend merely because the pack supports them.

## Validation

After project-wide setup:

1. inspect generated diff/files;
2. compile/build backend;
3. run relevant tests;
4. if frontend was added, let `spring-frontend` own frontend build validation;
5. report any unvalidated external dependency such as Docker or network access.
