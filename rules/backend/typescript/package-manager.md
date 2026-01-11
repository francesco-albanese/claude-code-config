---
paths: ["**/package.json", "**/.npmrc", "**/pnpm-workspace.yaml"]
---

# Package Management

## pnpm Configuration
- Use pnpm >= 10.28.0
- Set `minimum-release-age=10080` (1 week) in `.npmrc`
- Always use `pnpm` commands, never `npm` or `yarn`

## Workspaces
- Use `pnpm` workspaces for multi-package projects
- Common pattern: `packages/utils`, `packages/lambda-*`
