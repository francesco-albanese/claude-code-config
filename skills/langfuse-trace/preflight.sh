#!/usr/bin/env bash
set -euo pipefail

HOOK_SCRIPT="$HOME/.claude/hooks/langfuse_hook.py"
VENV_PY="$HOME/.claude/hooks/.venv-langfuse/bin/python"
GLOBAL_SETTINGS="$HOME/.claude/settings.json"
GLOBAL_LOCAL="$HOME/.claude/settings.local.json"

if [[ ! -f "$HOOK_SCRIPT" ]]; then
  echo "Missing: $HOOK_SCRIPT (hook script not installed)"
  exit 1
fi

if [[ ! -x "$VENV_PY" ]]; then
  echo "Missing: $VENV_PY (langfuse venv not installed)"
  exit 1
fi

if ! "$VENV_PY" -c "import langfuse" 2>/dev/null; then
  echo "langfuse package not importable in $VENV_PY"
  exit 1
fi

if ! jq -e '.hooks.Stop[]?.hooks[]?.command | select(test("langfuse_hook\\.py"))' "$GLOBAL_SETTINGS" >/dev/null 2>&1; then
  echo "Missing: Stop hook referencing langfuse_hook.py in $GLOBAL_SETTINGS"
  exit 1
fi

if [[ ! -f "$GLOBAL_LOCAL" ]]; then
  echo "Missing: $GLOBAL_LOCAL (global Langfuse keys not set)"
  exit 1
fi

for k in LANGFUSE_PUBLIC_KEY LANGFUSE_SECRET_KEY; do
  val=$(jq -r ".env.${k} // \"\"" "$GLOBAL_LOCAL")
  if [[ -z "$val" ]]; then
    echo "Missing: env.${k} in $GLOBAL_LOCAL"
    exit 1
  fi
  if [[ "$val" == *REPLACE_ME* ]]; then
    echo "Placeholder value for env.${k} in $GLOBAL_LOCAL — paste real key"
    exit 1
  fi
done

exit 0
