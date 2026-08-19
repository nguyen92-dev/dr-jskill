# AGENTS.md — Dr JSkill Modular Pack

These instructions govern work on this repository.

## Baseline

- Target Java 25 and Spring Boot 4.x unless the user explicitly requests another supported version.
- Maven is the default and supported build tool for this pack.
- Do not introduce Lombok unless the user explicitly overrides this repository policy.
- Prefer modern Java features that improve clarity without making code obscure.
- Keep generated projects buildable on Linux, macOS and Windows where the existing generator already supports them.

## Skill routing

Do not treat the repository as one giant Spring skill.

Use the narrowest relevant skill under `.agents/skills/`:

- project bootstrap/config → `spring-project`
- JPA/PostgreSQL → `spring-data-jpa`
- security → `spring-security`
- tests → `spring-testing`
- Angular/React/Vue/Vanilla → `spring-frontend`
- Docker/GraalVM/AOT/CRaC → `spring-container`
- Azure/deployment → `spring-deployment`
- Redis → `spring-redis`
- Elasticsearch → `spring-elasticsearch`

If a task spans multiple concerns, load only the skills needed for the current implementation step.

## References

The root `references/` directory is the canonical shared knowledge base.

- Do not duplicate large upstream references into skill folders.
- Read only references relevant to the task.
- Policy files under `references/skill-pack/` override conflicting recommendations in older upstream references for this fork.
- Preserve all upstream frontend references: Angular, React, Vue and Vanilla JS.

## Versions

`versions.json` is the single source of truth for pinned tool/library versions already managed by Dr JSkill.

When bumping a managed version:

1. edit `versions.json`;
2. run the upstream version synchronization script;
3. check generated docs/assets for drift;
4. smoke-test generation where practical.

Do not add a second version manifest for the modular skills.

## Scripts

For repository-maintenance scripts, follow the existing project convention:

- Node.js scripts use ES modules where appropriate;
- prefer Node built-in APIs when the existing generator does;
- keep cross-platform behavior for generator scripts.

Shell scripts added by the modular pack are installation/validation helpers only and must not become required runtime dependencies of generated applications.

## Secrets

- `.env` is a local secret store and must never be printed, copied into prompts, committed, or dumped.
- Reading `.env.sample` is allowed.
- If a task needs one secret/config value, ask for or inspect only that specific value through an appropriate safe mechanism.

## Database policy override

For this fork:

- production schema validation: `spring.jpa.hibernate.ddl-auto=validate`;
- prefer Flyway for versioned schema migrations;
- allow `ddl-auto=update` only when explicitly appropriate for prototype/local development;
- tests may use ephemeral schema creation strategies.

Read `references/skill-pack/DATABASE-POLICY.md` before making schema-management decisions.

## Security policy override

Prefer native Spring Security/OAuth2 Resource Server capabilities over a custom JWT filter stack.

Read `references/skill-pack/SECURITY-POLICY.md` before implementing authentication.

## Git

Do not commit, push, rewrite history, or initialize a repository unless the user explicitly asks for a Git write action.

Inspect diffs before proposing a commit.

## Validation

Before declaring a change complete, run the smallest meaningful validation first, then expand:

1. targeted compile/test;
2. `./mvnw test` when appropriate;
3. `./mvnw verify` for integration-sensitive backend changes;
4. frontend test/build for frontend changes;
5. container build only when container behavior changed.

If validation cannot run, state exactly what was not validated.
