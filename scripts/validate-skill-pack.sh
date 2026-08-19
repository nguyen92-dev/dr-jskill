#!/usr/bin/env bash
set -euo pipefail

ROOT="$(cd "$(dirname "${BASH_SOURCE[0]}")/.." && pwd)"
errors=0

expected_skills=(
  spring-project
  spring-data-jpa
  spring-security
  spring-testing
  spring-frontend
  spring-container
  spring-deployment
  spring-redis
  spring-elasticsearch
)

expected_refs=(
  references/ANGULAR.md
  references/AZURE.md
  references/CONFIGURATION.md
  references/DATABASE.md
  references/DOCKER.md
  references/GIT.md
  references/GRAALVM.md
  references/JDTLS.md
  references/LOGGING.md
  references/PROJECT-SETUP.md
  references/REACT.md
  references/SECURITY.md
  references/SPRING-BOOT-4.md
  references/TEST.md
  references/VANILLA-JS.md
  references/VUE.md
  references/skill-pack/DATABASE-POLICY.md
  references/skill-pack/SECURITY-POLICY.md
  references/skill-pack/FRONTEND-POLICY.md
  references/skill-pack/REDIS.md
  references/skill-pack/ELASTICSEARCH.md
)

echo "Validating skills..."
for name in "${expected_skills[@]}"; do
  f="$ROOT/.agents/skills/$name/SKILL.md"
  if [[ ! -f "$f" ]]; then
    echo "MISSING: $f"
    errors=$((errors+1))
    continue
  fi

  if ! grep -q '^name: ' "$f"; then
    echo "INVALID: missing frontmatter name in $f"
    errors=$((errors+1))
  fi
  if ! grep -q '^description: ' "$f"; then
    echo "INVALID: missing frontmatter description in $f"
    errors=$((errors+1))
  fi
done

echo "Validating references..."
for rel in "${expected_refs[@]}"; do
  if [[ ! -f "$ROOT/$rel" ]]; then
    echo "MISSING: $ROOT/$rel"
    errors=$((errors+1))
  fi
done

echo "Validating shared resources..."
for rel in versions.json scripts assets; do
  if [[ ! -e "$ROOT/$rel" ]]; then
    echo "MISSING: $ROOT/$rel"
    errors=$((errors+1))
  fi
done

if (( errors > 0 )); then
  echo
  echo "FAILED: $errors problem(s)"
  exit 1
fi

echo
echo "OK: modular skill pack structure is valid."
printf 'Skills: %s\n' "${expected_skills[*]}"
