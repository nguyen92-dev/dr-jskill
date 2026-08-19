---
name: spring-testing
description: Design and implement Spring Boot tests with JUnit, Mockito, Spring test slices, MockMvc/HTTP tests, integration tests and Testcontainers. Use for test strategy, failing tests, repository/controller/service tests, or verifying generated projects.
---

# Spring Testing

## Canonical reference

Read only the relevant sections of:

`../../../references/TEST.md`

## Strategy

Prefer the narrowest test that gives confidence:

1. pure unit test for isolated logic;
2. Spring test slice for web/data concerns;
3. integration test when framework/database wiring matters;
4. full application test only when the behavior crosses those boundaries.

## Database tests

For PostgreSQL-specific behavior, prefer Testcontainers over in-memory substitutes.

When migrations exist, integration tests should exercise the same migration path used by the application where practical.

## Mocking

Mock boundaries, not every internal class.

Avoid tests that merely restate implementation details.

## Naming

Use clear Given/When/Then or Arrange/Act/Assert structure.

## Validation

A generated project should not be considered healthy just because Node scripts parse.

When practical:

```bash
./mvnw test
./mvnw verify
```

If integration tests require Docker and Docker is unavailable, report that limitation explicitly.
