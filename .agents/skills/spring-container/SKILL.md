---
name: spring-container
description: Build and review Spring Boot containerization: Dockerfiles, Docker Compose, JVM images, Spring AOT, GraalVM native images, CRaC, runtime configuration, health checks and container build optimization. Use for container concerns, not cloud-provider deployment.
---

# Spring Container

## Canonical references

Read based on task:

- Docker/Compose/runtime → `../../../references/DOCKER.md`
- GraalVM/native → `../../../references/GRAALVM.md`

Do not load Azure deployment guidance unless deployment is actually requested.

## Workflow

1. Identify target:
   - normal JVM;
   - JVM + AOT;
   - native;
   - CRaC.
2. Reuse existing assets under `../../../assets/` rather than recreating equivalent Dockerfiles from memory.
3. Keep secrets outside images.
4. Use multi-stage builds where appropriate.
5. Keep runtime images minimal without making debugging/operations impossible.
6. Match health checks and exposed ports to application configuration.
7. Keep Compose development behavior distinct from production deployment configuration.

## Validation

When container behavior changes:

- build the relevant image;
- start it when environment permits;
- verify health/startup;
- verify application port/config injection;
- report when Docker/native tooling was unavailable.
