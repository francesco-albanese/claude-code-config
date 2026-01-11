---
paths: ["**/*.ts", "biome.json"]
---

# Code Quality

## BiomeJS
- Use BiomeJS for linting/formatting
- Run `biome check` before commit
- Run `biome --write` for auto fixes
- Run biome check --write to combine both

## Type Checking
- Run `tsc --noEmit`
- No TypeScript errors allowed
- No `any` allowed
- Prefer `type` over `interface`

## Pre-commit
- Husky hooks: `biome check` + `tsc --noEmit`
