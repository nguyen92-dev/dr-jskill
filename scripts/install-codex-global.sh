#!/usr/bin/env bash
set -euo pipefail

REPO_ROOT="$(cd "$(dirname "${BASH_SOURCE[0]}")/.." && pwd)"
INSTALL_DIR="${DR_JSKILL_INSTALL_DIR:-$HOME/.agents/dr-jskill-pack}"
SKILLS_DIR="$HOME/.agents/skills"

for required in ".agents/skills" references scripts assets versions.json; do
  if [[ ! -e "$REPO_ROOT/$required" ]]; then
    echo "ERROR: missing $REPO_ROOT/$required"
    echo "Run this script from a repository where the modular overlay has been applied."
    exit 1
  fi
done

mkdir -p "$INSTALL_DIR/.agents" "$SKILLS_DIR"

# Copy the pack so relative paths from skill folders to shared references remain valid.
rm -rf "$INSTALL_DIR/.agents/skills"
mkdir -p "$INSTALL_DIR/.agents/skills"
cp -a "$REPO_ROOT/.agents/skills/." "$INSTALL_DIR/.agents/skills/"

rm -rf "$INSTALL_DIR/references" "$INSTALL_DIR/scripts" "$INSTALL_DIR/assets"
cp -a "$REPO_ROOT/references" "$INSTALL_DIR/references"
cp -a "$REPO_ROOT/scripts" "$INSTALL_DIR/scripts"
cp -a "$REPO_ROOT/assets" "$INSTALL_DIR/assets"
cp "$REPO_ROOT/versions.json" "$INSTALL_DIR/versions.json"

for skill_path in "$INSTALL_DIR/.agents/skills"/*; do
  [[ -d "$skill_path" ]] || continue
  name="$(basename "$skill_path")"
  link="$SKILLS_DIR/$name"

  if [[ -e "$link" || -L "$link" ]]; then
    if [[ -L "$link" ]]; then
      rm "$link"
    else
      echo "SKIP: $link already exists and is not a symlink"
      continue
    fi
  fi

  ln -s "$skill_path" "$link"
  echo "Linked: $link -> $skill_path"
done

echo
echo "Installed Dr JSkill modular pack under:"
echo "  $INSTALL_DIR"
echo
echo "Codex user skill links:"
echo "  $SKILLS_DIR"
echo
echo "If Codex does not refresh the skill list automatically, restart the Codex session."
