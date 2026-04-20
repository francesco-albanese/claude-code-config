#!/usr/bin/env bash
set -euo pipefail

SKILL_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"

REPO_ROOT=$(git rev-parse --show-toplevel 2>/dev/null || pwd)

if [[ "$REPO_ROOT" == "$HOME" || "$REPO_ROOT" == "$HOME/.claude" ]]; then
  echo "Refusing to enable in $REPO_ROOT — run from a project repo, not \$HOME or ~/.claude."
  exit 1
fi

if ! bash "$SKILL_DIR/preflight.sh"; then
  echo
  echo "Global setup incomplete. Fix the above and retry."
  exit 1
fi

mkdir -p "$REPO_ROOT/.claude"
SETTINGS_FILE="$REPO_ROOT/.claude/settings.local.json"

HOST=$(jq -r '.env.LANGFUSE_BASE_URL // "https://cloud.langfuse.com"' "$HOME/.claude/settings.local.json" 2>/dev/null || echo "https://cloud.langfuse.com")

if [[ -f "$SETTINGS_FILE" ]]; then
  CURRENT=$(jq -r '.env.TRACE_TO_LANGFUSE // ""' "$SETTINGS_FILE")
  if [[ "$CURRENT" == "true" ]]; then
    echo "Already enabled."
    echo "  Host: $HOST"
    exit 0
  fi
  TMP=$(mktemp)
  jq '.env.TRACE_TO_LANGFUSE = "true"' "$SETTINGS_FILE" > "$TMP" && mv "$TMP" "$SETTINGS_FILE"
else
  printf '%s\n' '{"env":{"TRACE_TO_LANGFUSE":"true"}}' | jq '.' > "$SETTINGS_FILE"
fi

GITIGNORE="$REPO_ROOT/.gitignore"
PATTERN=".claude/settings.local.json"
if [[ -f "$GITIGNORE" ]]; then
  if ! grep -Fxq "$PATTERN" "$GITIGNORE"; then
    echo "$PATTERN" >> "$GITIGNORE"
  fi
else
  echo "$PATTERN" > "$GITIGNORE"
fi

echo "✓ Langfuse tracing enabled → .claude/settings.local.json"
echo "  Host: $HOST"
echo "  Verify: run a turn, check ~/.claude/state/langfuse_hook.log"
