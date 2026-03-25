#!/bin/bash
# block-npm-npx.sh — Block npx/npm commands, suggest pnpx/pnpm

INPUT=$(cat)
COMMAND=$(echo "$INPUT" | jq -r '.tool_input.command // empty')

BLOCKED=("npx" "npm")

for pattern in "${BLOCKED[@]}"; do
  # Only block if the command itself starts with npx/npm (with optional leading whitespace)
  # This avoids false positives when npm/npx appear in commit messages or comments
  if echo "$COMMAND" | grep -qE "^[[:space:]]*(${pattern})[[:space:]]"; then
    echo "Blocked: use pnpx/pnpm instead of npx/npm" >&2
    exit 2
  fi
done

exit 0
