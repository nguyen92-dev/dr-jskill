---
name: spring-frontend
description: Add or maintain a frontend integrated with Spring Boot using Angular, React, Vue, or Vanilla JS. Use for frontend scaffolding, SPA routing, API proxying, Maven frontend integration, frontend build/test, or choosing among the supported frontend frameworks.
---

# Spring Frontend

## First rule: choose one reference

Do not read all frontend guides unless the user is explicitly comparing frameworks.

Route by framework:

- Angular → `../../../references/ANGULAR.md`
- React → `../../../references/REACT.md`
- Vue → `../../../references/VUE.md`
- Vanilla JS → `../../../references/VANILLA-JS.md`

Always read the integration policy when changing how frontend artifacts are packaged:

`../../../references/skill-pack/FRONTEND-POLICY.md`

## Workflow

1. Detect existing frontend before scaffolding a new one.
2. Respect the framework already chosen by the project.
3. If no framework is chosen and the user asks for a comparison, compare first; do not scaffold until a choice is made or the task requires a default.
4. Keep frontend development workflow independent from backend startup when possible.
5. Use a development proxy for `/api` rather than hard-coding backend origins across source files.
6. Keep generated build artifacts out of source-controlled application source directories where practical.
7. Integrate the production frontend build into Maven only when the application is meant to ship frontend assets inside the backend artifact.
8. Validate both frontend and backend packaging paths.

## Supported frameworks

### Angular

Use Angular CLI conventions and standalone APIs appropriate to the pinned Angular version.

### React

Use Vite/React conventions from the canonical reference.

### Vue

Use the canonical Vue guide, including the documented scaffolding/test caveats.

### Vanilla

Keep the toolchain minimal; do not introduce a framework accidentally.

## Validation

Typical checks:

```bash
cd frontend
npm test       # if configured
npm run build
```

Then verify the Spring Boot package serves the expected production assets when the architecture bundles them.
