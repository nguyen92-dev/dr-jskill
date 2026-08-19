# Frontend Integration Policy

All four upstream frontend references remain canonical and supported:

- `ANGULAR.md`
- `REACT.md`
- `VUE.md`
- `VANILLA-JS.md`

## Progressive disclosure

If the project uses Angular, read Angular guidance only.

Do not load React/Vue/Vanilla references unless:

- comparing frameworks;
- migrating between frameworks;
- troubleshooting shared tooling.

## Development

Prefer a separate frontend dev server with API proxying during development.

Avoid hard-coded backend origins in business code.

## Production packaging

If the architecture bundles the SPA inside the Spring Boot JAR:

1. build frontend into its normal generated output (`dist/` or framework equivalent);
2. copy/process that output into Maven's build output (`target/classes/static` or an equivalent resource-processing path);
3. avoid treating generated frontend artifacts as source code.

If an existing project already intentionally writes generated files into `src/main/resources/static`, do not rewrite it automatically; propose the migration and explain the trade-off.

## API contracts

Do not introduce generated OpenAPI clients unless the project explicitly adopts that workflow.

Keep authentication/error handling consistent with backend security architecture.

## Validation

For frontend changes:

```bash
npm run build
```

Run framework tests/lint when configured.

If bundled into Spring Boot, also validate the packaged application contains/serves the expected assets.
