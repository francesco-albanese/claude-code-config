#!/bin/bash
# Ralph Wiggum Bootstrap Script
# Creates scripts/ralph/ directory and copies templates

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

# Copy templates
cp "$TEMPLATE_DIR/prompt.md" "$TARGET_DIR/"
cp "$TEMPLATE_DIR/prd.json" "$TARGET_DIR/"
cp "$TEMPLATE_DIR/progress.txt" "$TARGET_DIR/"

echo "Ralph templates copied to $TARGET_DIR/"
echo ""
echo "Files created:"
echo "  - $TARGET_DIR/prompt.md (Claude instructions)"
echo "  - $TARGET_DIR/prd.json (task list - EDIT THIS)"
echo "  - $TARGET_DIR/progress.txt (iteration log)"
echo ""
echo "Next steps:"
echo "  1. Edit $TARGET_DIR/prd.json with your tasks"
echo "  2. Run: ralph-once (single iteration)"
echo "  3. Or:  afk-ralph (10 iterations)"
