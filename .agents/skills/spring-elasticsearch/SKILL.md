---
name: spring-elasticsearch
description: Add or review Elasticsearch full-text search for Spring Boot: index/document modeling, analyzers, mappings, Spring Data Elasticsearch, indexing pipelines, PostgreSQL-to-search synchronization and search consistency. Elasticsearch is opt-in.
---

# Spring Elasticsearch

## Canonical reference

Read:

`../../../references/skill-pack/ELASTICSEARCH.md`

## Architecture default

Unless the user explicitly chooses otherwise:

- PostgreSQL is the transactional source of truth.
- Elasticsearch is a derived search index.
- Search indexing is eventually consistent.
- Business writes must not depend on Elasticsearch being synchronously available.

## Workflow

1. Prove the use case needs search-engine capabilities beyond PostgreSQL.
2. Define searchable document shape separately from JPA entity shape.
3. Define mappings/analyzers explicitly.
4. Define indexing trigger:
   - synchronous after commit for simple cases;
   - event/outbox-driven for stronger reliability at scale.
5. Define reindex strategy.
6. Define deletion/tombstone behavior.
7. Define search API pagination/sorting.
8. Test mapping/index compatibility and degraded behavior.

Do not use Elasticsearch as a cache.
