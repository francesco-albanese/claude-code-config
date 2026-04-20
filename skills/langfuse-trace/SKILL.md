---
name: langfuse-trace
description: Enable/disable/inspect Langfuse tracing for the current project. Args - (none or `on`) enables, `off` disables, `status` reports state. Use when user wants to start or stop sending Claude Code session traces to Langfuse for this repo.
---

Dispatch based on the argument after `/langfuse-trace`:

- no arg OR `on` → run `bash ~/.claude/skills/langfuse-trace/enable.sh`
- `off` → run `bash ~/.claude/skills/langfuse-trace/disable.sh`
- `status` → run `bash ~/.claude/skills/langfuse-trace/status.sh`
- anything else → print: `Usage: /langfuse-trace [on|off|status]`

Relay the script's stdout to the user verbatim. Do not add commentary, headers, or summaries.
