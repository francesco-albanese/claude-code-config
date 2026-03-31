#!/bin/bash
# Ralph Wiggum Bootstrap Script
# Creates scripts/ralph/ directory and copies prompt template

set -e

TEMPLATE_DIR="$HOME/Documents/Development/ralph-wiggum-claude/templates"
TARGET_DIR="scripts/ralph"

# Check template source exists
if [ ! -d "$TEMPLATE_DIR" ]; then
    echo "Error: Template directory not found: $TEMPLATE_DIR"
    exit 1
fi

# Create target directory
mkdir -p "$TARGET_DIR"

# Copy template
cp "$TEMPLATE_DIR/prompt.md" "$TARGET_DIR/"

echo "Ralph template copied to $TARGET_DIR/"
echo ""
echo "Files created:"
echo "  - $TARGET_DIR/prompt.md (Claude instructions)"
echo ""
echo "Next steps:"
echo "  1. Run: ralph-once (single iteration)"
echo "  2. Or:  afk-ralph (10 iterations)"
