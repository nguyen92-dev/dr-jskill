# Migration Guide: monolithic `dr-jskill` → modular skill pack

## What stays untouched

The overlay does not delete or replace the upstream directories below:

```text
references/
scripts/
assets/
versions.json
docs/
workshop/
```

It only adds new files under `references/skill-pack/`, `.agents/skills/`, and two helper scripts.

Root `README.md`, `SKILL.md`, and `AGENTS.md` are replaced by the overlay, but the apply script backs the old files up first.

## Apply

```bash
./tools/apply-overlay.sh /path/to/dr-jskill
```

Backup location:

```text
docs/upstream-snapshots/<timestamp>/
```

## Validate

```bash
cd /path/to/dr-jskill
./scripts/validate-skill-pack.sh
```

## Expected skills

```text
spring-project
spring-data-jpa
spring-security
spring-testing
spring-frontend
spring-container
spring-deployment
spring-redis
spring-elasticsearch
```

## Roll back root docs

Copy the backup files back:

```bash
cp docs/upstream-snapshots/<timestamp>/README.md .
cp docs/upstream-snapshots/<timestamp>/SKILL.md .
cp docs/upstream-snapshots/<timestamp>/AGENTS.md .
```

The added `.agents/skills/` and `references/skill-pack/` directories can then be removed manually if desired.

## Why references are not physically moved

Moving `references/SECURITY.md` into a skill would make the upstream layout harder to sync and would duplicate large documents across skills.

This pack treats the root `references/` directory as a shared knowledge base. Skills own the **routing/workflow**, while references own **deep knowledge/examples**.
