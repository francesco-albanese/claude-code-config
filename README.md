# Claude Code Configuration

Personal Claude Code configuration using the **progressive disclosure pattern**.

## Approach

Following [Writing a Good CLAUDE.md](https://www.humanlayer.dev/blog/writing-a-good-claude-md) by HumanLayer:

- Keep `CLAUDE.md` minimal (~60 lines ideal)
- Use pointers not copies - reference external files
- Claude reads relevant rules on-demand vs loading everything upfront

## Progressive Disclosure Pattern

```
CLAUDE.md           <- concise core instructions + rules index
rules/
  frontend/         <- React, testing, Tailwind, etc.
  backend/
    python/         <- FastAPI, pytest, async patterns
    typescript/     <- Lambda patterns, Vitest
  infrastructure/   <- Terraform conventions
```

`CLAUDE.md` contains a **Rules Index** pointing to domain-specific files. Claude reads only the relevant rules for each task.

## Directory Structure

| Directory | Purpose |
|-----------|---------|
| `CLAUDE.md` | Core instructions, preferences, rules index |
| `rules/` | Task-specific rules (progressive disclosure) |
| `agents/` | Custom agent definitions (git-ops, senior-python-dev) |
| `commands/` | Slash commands (commit-push, create-pr, etc.) |
| `skills/` | Complex multi-step skills (terraform-bootstrap) |

## Why Progressive Disclosure?

LLMs can reliably follow ~150-200 instructions. Claude Code's system prompt uses ~50. Loading irrelevant context degrades performance uniformly. Solution: load rules only when needed.
