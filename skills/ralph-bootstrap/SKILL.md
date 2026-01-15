---
name: ralph-bootstrap
description: Bootstrap Ralph Wiggum autonomous coding templates in current project. Creates scripts/ralph/ dir and copies templates (prompt.md, prd.json, progress.txt). Use when users request (1) Setup/bootstrap/init Ralph Wiggum, (2) Add ralph templates to project, (3) Configure autonomous coding loop, (4) Setup AFK mode for Claude, (5) Initialize ralph-once or afk-ralph.
allowed-tools: Bash, Write
---

# Ralph Bootstrap

Bootstrap Ralph Wiggum templates for autonomous AI coding in the current project.

## Quick Start

Run the bootstrap script:

```bash
~/.claude/skills/ralph-bootstrap/scripts/bootstrap.sh
```

This creates `scripts/ralph/` with all required templates.

## Files Created

```
scripts/ralph/
├── prompt.md      # Instructions for Claude
├── prd.json       # Task list (user stories) - EDIT THIS
└── progress.txt   # Progress log between iterations
```

## Usage After Bootstrap

```bash
# HITL mode - single iteration
ralph-once

# AFK mode - 10 iterations (default)
afk-ralph

# AFK mode - custom iterations
afk-ralph 25
```
