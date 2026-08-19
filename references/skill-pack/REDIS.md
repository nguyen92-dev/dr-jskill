# Redis for Spring Boot — Optional Reference

Redis is **not a default dependency** in this pack.

Use it when the application has a concrete ephemeral/shared-state problem.

## Common good fits

- cache expensive read-mostly results;
- shared refresh-token/session metadata;
- counters/rate-limit data;
- short-lived distributed coordination;
- idempotency markers with well-defined TTL.

## Cache design

Define keys with stable namespaces:

```text
<app>:<domain>:<purpose>:<identifier>
```

Example:

```text
expense:category:by-id:42
```

For user/tenant-sensitive data, include the isolation key when needed.

## TTL

TTL is part of the data contract.

Avoid "forever" by default for derived cache data.

Different cache entries may need different TTLs; do not force one global value.

## Invalidation

Choose one:

- cache-aside with explicit eviction on writes;
- short TTL and tolerate staleness;
- event-driven invalidation.

Document consistency expectations.

## Failure mode

For non-critical cache:

- Redis unavailable → fall back to source of truth;
- avoid turning a cache outage into an application-wide outage where possible.

For critical Redis-backed state such as rate limits or token/session data, define fail-open vs fail-closed intentionally.

## Spring options

Typical abstractions:

- Spring Cache (`@Cacheable`, `@CacheEvict`);
- `RedisTemplate`/typed operations when cache annotations are too limited.

Avoid mixing several serialization formats for the same key space.

## Serialization

Prefer explicit, versionable payloads.

Be careful with Java native serialization and class-name-coupled payloads.

## Observability

Useful metrics:

- hits/misses;
- latency;
- evictions;
- memory usage;
- fallback count;
- errors/timeouts.

## Testing

Test:

- hit;
- miss;
- invalidation;
- TTL-sensitive behavior where practical;
- Redis unavailable/fallback path.
