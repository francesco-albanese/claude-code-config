---
description: Run code-quality-verifier agent against a spec to audit implementation quality
---

Run a quality gate audit on the current branch's changes against a specification.

## 1. Find the Spec

If `$ARGUMENTS` is provided and non-empty, use it as the path to the spec file. Read it.

Otherwise, search for specs:
- Glob `~/.claude/plans/*.md` for active plans
- Glob `**/prd*.json` and `**/prd*.md` in the current project for PRDs

If multiple specs found, ask me which one to use (AskUserQuestion). If none found, ask me to provide a path.

## 2. Gather Git Diff

Run `git diff main...HEAD` to capture all changes on this branch. If that fails (no `main` branch), fall back to `git diff master...HEAD`. If both fail, use `git diff HEAD~5...HEAD` as last resort.

Also run `git log --oneline main...HEAD` (same fallback logic) to understand commit history.

## 3. Launch Quality Audit

Use the Task tool with `subagent_type: "code-quality-verifier"` passing:
- The full spec/PRD content
- The git diff summary (truncate if extremely large, focus on file list + key changes)
- The current project working directory path
- Instruction to produce the standard verification summary with severity levels

## 4. Report Findings

Present the agent's findings directly in the terminal. Do not write any output files. Include the full verification summary with:
- PRD Compliance status
- Security assessment
- Test quality assessment
- Architecture alignment
- All issues with severity levels and file:line references
- Required actions
