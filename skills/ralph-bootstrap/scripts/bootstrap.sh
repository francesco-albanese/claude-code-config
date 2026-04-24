#!/bin/bash
# Ralph Wiggum Bootstrap Script
# Creates scripts/ralph/ directory and copies the tracker-specific prompt template.
#
# Usage: bootstrap.sh [github|beads]
# Default: github

set -e

BACKEND="${1:-github}"
TEMPLATE_DIR="$HOME/Documents/Development/ralph-wiggum-claude/templates"
TARGET_DIR="scripts/ralph"

case "$BACKEND" in
    github|beads) ;;
    *)
        echo "Error: unknown backend '$BACKEND' (expected: github or beads)"
        exit 1
        ;;
esac

SOURCE_FILE="$TEMPLATE_DIR/prompt-$BACKEND.md"

if [ ! -f "$SOURCE_FILE" ]; then
    echo "Error: template not found: $SOURCE_FILE"
    exit 1
fi

mkdir -p "$TARGET_DIR"
cp "$SOURCE_FILE" "$TARGET_DIR/prompt.md"

echo "Ralph template ($BACKEND) copied to $TARGET_DIR/prompt.md"
echo ""
echo "Files created:"
echo "  - $TARGET_DIR/prompt.md (Claude instructions, tracker=$BACKEND)"
echo ""
echo "Next steps:"
echo "  1. Run: ralph-once (single iteration)"
echo "  2. Or:  afk-ralph (10 iterations)"
