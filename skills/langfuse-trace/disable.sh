#!/usr/bin/env bash
set -euo pipefail

REPO_ROOT=$(git rev-parse --show-toplevel 2>/dev/null || pwd)

if [[ "$REPO_ROOT" == "$HOME" || "$REPO_ROOT" == "$HOME/.claude" ]]; then
  echo "Refusing to disable in $REPO_ROOT — run from a project repo, not \$HOME or ~/.claude."
  exit 1
fi

SETTINGS_FILE="$REPO_ROOT/.claude/settings.local.json"

if [[ ! -f "$SETTINGS_FILE" ]]; then
  echo "Already disabled (no .claude/settings.local.json)."
  exit 0
fi

CURRENT=$(jq -r '.env.TRACE_TO_LANGFUSE // ""' "$SETTINGS_FILE")
if [[ "$CURRENT" != "true" ]]; then
  echo "Already disabled."
  exit 0
fi

TMP=$(mktemp)
jq 'del(.env.TRACE_TO_LANGFUSE) | if (.env // {}) == {} then del(.env) else . end' "$SETTINGS_FILE" > "$TMP" && mv "$TMP" "$SETTINGS_FILE"

echo "✓ Langfuse tracing disabled"
