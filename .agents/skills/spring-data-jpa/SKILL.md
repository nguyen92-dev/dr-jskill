---
name: spring-data-jpa
description: Implement and review Spring Data JPA, Hibernate and PostgreSQL persistence: entities, mappings, repositories, transactions, pagination, fetching, N+1, batching, locking, schema migration and query performance. Use for database/persistence work; not for general project bootstrap.
---

# Spring Data JPA

## Required references

Read:

1. `../../../references/skill-pack/DATABASE-POLICY.md`
2. the relevant section of `../../../references/DATABASE.md`

The skill-pack policy wins if the upstream reference conflicts with it.

## Workflow

1. Identify whether the task is:
   - domain/entity mapping;
   - query/repository design;
   - transaction/concurrency;
   - schema migration;
   - performance;
   - integration testing.
2. Preserve PostgreSQL as the default source of truth unless the project says otherwise.
3. Model relationships deliberately:
   - avoid eager collections by default;
   - use `@EntityGraph`, fetch joins, projections, or explicit queries when needed;
   - check cascade/orphan semantics rather than copying defaults.
4. Use pagination for unbounded list endpoints.
5. For large/deep pagination, consider keyset pagination.
6. For writes, consider transaction boundaries, batching, optimistic locking and idempotency.
7. For schema evolution, apply the database policy below.
8. Validate with repository/integration tests against PostgreSQL/Testcontainers when behavior is database-specific.

## Schema management

Default for long-lived applications:

```properties
spring.jpa.hibernate.ddl-auto=validate
```

Prefer Flyway for versioned migrations.

`update` is allowed only for explicit prototype/local convenience, not as a silent production strategy.

## Query performance checklist

Before adding cache:

- eliminate obvious N+1;
- avoid fetching unused graphs;
- add/verify indexes;
- inspect query plans for expensive queries;
- project only needed columns for read-heavy screens;
- measure batch behavior for bulk writes.

Use Redis only after the database/query shape is sensible and the use case warrants caching.

## Validation

Use the smallest relevant layer first:

- repository test;
- integration test with PostgreSQL/Testcontainers;
- `./mvnw test`;
- `./mvnw verify` when integration behavior is affected.
