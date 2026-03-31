---
name: ralph-bootstrap
description: This skill should be used when the user asks to: "initialise Ralph", "bootstrap Ralph", "set up Ralph Wiggum", "add Ralph to project", "create Ralph directory" or wants to set up autonomous coding loops with Ralph.
---

# Ralph Bootstrap

Initialise Ralph Wiggum Autonomous Coding loop in current project.

## Prerequisites

- `gh` CLI installed and authenticated
- Github task issues created iva `/prd-to-issues` skill

## Run the bootstrap script

```bash
~/.claude/skills/ralph-bootstrap/scripts/bootstrap.sh
```

This creates `scripts/ralph/` directory with prompt template.

## Files Created

```
scripts/ralph/
├── prompt.md # Instructions for Claude (reads tasks from Github issues)
```

## Usage After Bootstrap

```bash
# HITL mode - single iteration
ralph-once

# AFK mode - 10 iterations (default)
afk-ralph 25
```

## Workflow

1. `/write-a-prd` - create PRD as Github issue
2. `/prd-to-issues` - break PRD into tasks issues + create Progress Log
3. `/ralph-bootstrap` - set up local prompt in project
4. `ralph-once` or `afk-ralph` - run autonomous coding loops
