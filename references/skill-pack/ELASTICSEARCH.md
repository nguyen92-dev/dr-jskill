# Elasticsearch for Spring Boot — Optional Reference

Elasticsearch is **not a default dependency** in this pack.

Use it for search capabilities that justify a separate search engine, such as:

- full-text relevance;
- language analysis/tokenization;
- fuzzy matching;
- faceted search/aggregations;
- complex search ranking.

For ordinary exact filtering, relational joins and simple prefix search, PostgreSQL may be sufficient.

## Source of truth

Default architecture:

```text
PostgreSQL = transactional source of truth
Elasticsearch = derived search index
```

Do not require Elasticsearch to succeed before committing a normal business transaction unless the architecture explicitly accepts that coupling.

## Search document

Model the Elasticsearch document for search, not as a 1:1 dump of the JPA entity graph.

Denormalization is normal.

Include only fields needed for:

- query;
- filter;
- sort;
- display/search result projection.

## Mapping

Define mappings/analyzers deliberately.

Avoid accidental dynamic mappings for important fields.

Examples of choices to make:

- `keyword` vs `text`;
- lowercase/normalizers;
- language analyzers;
- n-gram/edge n-gram;
- date/numeric types.

## Synchronization

Simple/small system:

```text
DB commit → after-commit indexing
```

More reliable/scalable:

```text
DB transaction
  → outbox/event
  → async indexer
  → Elasticsearch
```

The second model tolerates Elasticsearch outages better and supports replay.

## Reindexing

Always have a plan to rebuild an index from the source of truth.

Prefer versioned index names plus alias switch for larger production migrations.

## Deletes

Define how deleted/disabled rows disappear from search.

Soft-delete flags may require explicit search document removal/update.

## Consistency

Search is commonly eventually consistent.

APIs/UI should not promise immediate read-after-write search visibility unless the system actually provides it.

## Pagination

Avoid deep offset pagination for very large result sets.

Use Elasticsearch mechanisms appropriate to the use case such as `search_after` for deep traversal.

## Testing

Cover:

- mapping creation;
- indexing;
- update/delete propagation;
- query relevance/filter behavior;
- reindex path;
- Elasticsearch unavailable path where application writes must continue.
