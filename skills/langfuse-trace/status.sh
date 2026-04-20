#!/usr/bin/env bash
set -euo pipefail

SKILL_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"

REPO_ROOT=$(git rev-parse --show-toplevel 2>/dev/null || pwd)

SETTINGS_FILE="$REPO_ROOT/.claude/settings.local.json"
FLAG="OFF"
if [[ -f "$SETTINGS_FILE" ]]; then
  CURRENT=$(jq -r '.env.TRACE_TO_LANGFUSE // ""' "$SETTINGS_FILE")
  [[ "$CURRENT" == "true" ]] && FLAG="ON"
fi

HOST=$(jq -r '.env.LANGFUSE_BASE_URL // "https://cloud.langfuse.com"' "$HOME/.claude/settings.local.json" 2>/dev/null || echo "https://cloud.langfuse.com")

if PRE_OUT=$(bash "$SKILL_DIR/preflight.sh" 2>&1); then
  PRE_OK=1
else
  PRE_OK=0
fi

echo "Tracing: $FLAG"
if [[ "$PRE_OK" -eq 1 ]]; then
  echo "  Global setup: ✓"
else
  FIRST=$(echo "$PRE_OUT" | head -n 1)
  echo "  Global setup: ✗ ($FIRST)"
fi
echo "  Host: $HOST"
echo "  Repo: $REPO_ROOT"
