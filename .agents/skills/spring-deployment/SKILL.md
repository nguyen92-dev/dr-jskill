---
name: spring-deployment
description: Deploy Spring Boot applications and containers, especially Azure Container Apps and CI-based image publishing. Use for Azure deployment, deployment pipelines, registry/image release flow, runtime secrets and production deployment configuration.
---

# Spring Deployment

## Canonical references

Read:

- Azure-specific work → `../../../references/AZURE.md`
- container packaging dependency → relevant sections of `../../../references/DOCKER.md`

Inspect existing CI assets under `../../../assets/ci/` before inventing a second workflow.

## Workflow

1. Identify deployment target and environment.
2. Separate build-time configuration from runtime secrets.
3. Decide image registry and immutable tag strategy.
4. Reuse/test the container path before cloud deployment.
5. Use workload identity/OIDC where the existing deployment model supports it instead of long-lived CI secrets.
6. Keep database provisioning/migrations explicit.
7. Validate health, rollout and rollback expectations.

Do not add Azure-specific files to projects that are not being deployed to Azure.
