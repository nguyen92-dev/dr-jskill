# Database Policy Override

This file intentionally overrides the upstream Dr JSkill recommendation that Hibernate `ddl-auto` should be the primary schema-management mechanism.

## Default policy

### Long-lived development and production applications

Use versioned migrations.

Preferred default:

```text
Flyway
```

Runtime schema behavior:

```properties
spring.jpa.hibernate.ddl-auto=validate
```

This gives two separate responsibilities:

- Flyway changes the schema;
- Hibernate validates entity/schema compatibility.

### Prototype or disposable local development

`ddl-auto=update` is acceptable when explicitly chosen for speed and when schema history/rollback/auditability are not requirements.

Do not silently carry this setting into production.

### Tests

Choose based on the test purpose:

- migration integration test → run migrations against ephemeral PostgreSQL;
- repository behavior test → ephemeral PostgreSQL/Testcontainers;
- disposable isolated schema → create/create-drop can be acceptable.

## Migration rules

- migrations are append-only after being applied to shared environments;
- use descriptive versioned migration names;
- keep destructive migrations explicit;
- separate data backfills from risky DDL when operationally useful;
- verify indexes/constraints in the actual target PostgreSQL version.

## JPA/Hibernate rules

- prefer `LAZY` for collections unless there is a measured reason otherwise;
- disable Open Session in View for API backends;
- use optimistic locking where lost updates matter;
- avoid returning entities directly from public APIs by default;
- use projections for read-heavy endpoints when full entity hydration is wasteful;
- inspect SQL/query plans before adding cache as a performance band-aid.

## PostgreSQL remains the default source of truth

Redis and Elasticsearch are optional derived/ephemeral systems unless the user explicitly chooses a different architecture.
