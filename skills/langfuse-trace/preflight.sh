#!/usr/bin/env bash
set -euo pipefail

HOOK_SCRIPT="$HOME/.claude/hooks/langfuse_hook.py"
VENV_PY="$HOME/.claude/hooks/.venv-langfuse/bin/python"
GLOBAL_SETTINGS="$HOME/.claude/settings.json"
SECRETS_FILE="$HOME/.claude/langfuse-secrets.json"

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

if [[ ! -f "$SECRETS_FILE" ]]; then
  echo "Missing: $SECRETS_FILE (create with LANGFUSE_PUBLIC_KEY + LANGFUSE_SECRET_KEY)"
  exit 1
fi

for k in LANGFUSE_PUBLIC_KEY LANGFUSE_SECRET_KEY; do
  val=$(jq -r ".${k} // \"\"" "$SECRETS_FILE")
  if [[ -z "$val" ]]; then
    echo "Missing: ${k} in $SECRETS_FILE"
    exit 1
  fi
  if [[ "$val" == *REPLACE_ME* ]]; then
    echo "Placeholder value for ${k} in $SECRETS_FILE — paste real key"
    exit 1
  fi
done

exit 0
