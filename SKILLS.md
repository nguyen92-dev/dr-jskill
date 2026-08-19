# Skill Catalog

File này **không phải file đặc biệt của Agent Skills specification**. Nó chỉ là catalog cho con người đọc nhanh.

Codex discover skill thật từ:

```text
.agents/skills/<skill-name>/SKILL.md
```

## Catalog

### `spring-project`

**Trigger:** bootstrap/new Spring Boot project, project structure, base configuration, versioning, starter dependencies, dotfiles, JDTLS, logging.

**Không chịu trách nhiệm chính:** business security, deep JPA tuning, frontend framework implementation, deployment.

Canonical references:

- `references/SPRING-BOOT-4.md`
- `references/PROJECT-SETUP.md`
- `references/CONFIGURATION.md`
- `references/LOGGING.md`
- `references/JDTLS.md`
- `references/GIT.md`

---

### `spring-data-jpa`

**Trigger:** JPA/Hibernate/PostgreSQL, entity mapping, query, transaction, pagination, N+1, batching, database schema.

Canonical references:

- `references/DATABASE.md`
- `references/skill-pack/DATABASE-POLICY.md`

---

### `spring-security`

**Trigger:** Spring Security, authentication, authorization, JWT, OAuth2/OIDC, Keycloak, CORS/CSRF related security.

Canonical references:

- `references/SECURITY.md`
- `references/skill-pack/SECURITY-POLICY.md`

---

### `spring-testing`

**Trigger:** JUnit, Mockito, Spring test slices, integration tests, Testcontainers, test strategy.

Canonical reference:

- `references/TEST.md`

---

### `spring-frontend`

**Trigger:** add/build/refactor frontend integrated with Spring Boot.

Canonical references:

- Angular → `references/ANGULAR.md`
- React → `references/REACT.md`
- Vue → `references/VUE.md`
- Vanilla → `references/VANILLA-JS.md`
- policy → `references/skill-pack/FRONTEND-POLICY.md`

Only read the selected framework reference unless comparing frameworks.

---

### `spring-container`

**Trigger:** Dockerfile, Docker Compose, JVM/AOT/native/CRaC container build, GraalVM.

Canonical references:

- `references/DOCKER.md`
- `references/GRAALVM.md`

---

### `spring-deployment`

**Trigger:** Azure deployment, deployment CI, image publishing, deployment configuration.

Canonical references:

- `references/AZURE.md`
- `references/DOCKER.md`

---

### `spring-redis`

**Trigger:** Spring Cache with Redis, RedisTemplate, distributed cache, session/token/cache key design, TTL, invalidation.

Canonical reference:

- `references/skill-pack/REDIS.md`

Optional. Do not add Redis just because the skill exists.

---

### `spring-elasticsearch`

**Trigger:** Elasticsearch full-text search, indexing, search documents, Spring Data Elasticsearch, sync from PostgreSQL.

Canonical reference:

- `references/skill-pack/ELASTICSEARCH.md`

Optional. PostgreSQL remains the default source of truth unless user explicitly chooses another architecture.
