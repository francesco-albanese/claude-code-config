---
paths: ["**/lambda-*/**", "**/lambdas/**", "**/handlers/**", "**/esbuild.config.js"]
---

# AWS Lambda (TypeScript)

## Runtime & Build
- Target: `nodejs24.x` runtime
- Use esbuild for bundling
- Output: ESM format with `.mjs` extension
- Bundle for production: `platform: 'node'`, `format: 'esm'`
- Never bundle @aws-sdk packages, included in nodejs24x runtime
- Add externals for node internals and @aws-sdk in esbuild config
- Prefer `"node:os"`, `"node:crypto"` imports

## AWS SDK V3
- Import specific service clients only
- Examples: `@aws-sdk/client-s3`, `@aws-sdk/client-dynamodb`
- Never use full `aws-sdk` v2 package

## Workspace Structure
- `packages/utils/` - common utilities
- `packages/types/` - shared TypeScript types
- `packages/lambda-*/` - individual lambda functions

## Dependencies
- `@types/aws-lambda` for handler types
- Axios for HTTP, define shared instance in `utils/axios`

## Code Quality
- TypeScript strict mode
- Run `tsc --noEmit` for type checking
- BiomeJS for linting/formatting
- Vitest for unit tests
