- When reporting information to me, be extremely concise and sacrifice grammar for the sake of concision.
- In all interactions and commit messages, be extremely concise and sacrifice grammar for the sake of concision.

## PR Comments

- When tagging Claude in GitHub issues, use '@claude', The description of the change should be user-facing, describing which features were added or bugs were fixed.

## GitHub

- Your primary method for interacting with GitHub should be the GitHub CLI.

## Git

- When creating branches, use semantic branch names https://gist.github.com/seunggabi/87f8c722d35cd07deb3f649d45a31082
- When committing and pushing co-author myself Francesco Albanese by reading the information from .git folder or using git config --global --list | grep -E 'user.name|user.email'

## Plans

- At the end of each plan, give me a list of unresolved questions to answer, if any. Make the questions extremely concise. Sacrifice grammar for the sake of concision.
- When you generate a plan and  present it to me in the terminal print only a concise summary + headings, sacrifice grammar for the sake of concision.
- When you are done implementing the plan clean up after yourself, when the plan is not needed delete it from ~/.claude/plans

## Custom Agents

You can use the following agents:

- senior-python-dev - use it for ALL  Python applications
- git-ops - use it for ALL git operations, following the Git preferences described above

## Agentic Coding

- If you create any temporary new files, scripts, or helper files for iteration, clean up these files by removing them at the end of the task.

## Rules Index

Task-specific rules in `~/.claude/rules/`. Read relevant files before starting work:

**Frontend:**
- `frontend/react-stack.md` - React/Vite/Tailwind setup
- `frontend/tanstack.md` - Tanstack ecosystem libs
- `frontend/testing.md` - Vitest, Playwright, RTL
- `frontend/code-quality.md` - BiomeJS, TypeScript
- `frontend/ai-apps.md` - Vercel AI SDK, Mastra
- `frontend/ssg-cms.md` - Gatsby, Contentful

**Backend TypeScript:**
- `backend/typescript/lambdas.md` - AWS Lambda patterns
- `backend/typescript/testing.md` - Vitest, mocking
- `backend/typescript/code-quality.md` - BiomeJS, tsc

**Backend Python:**
- `backend/python/package-manager.md` - uv, venv
- `backend/python/code-quality.md` - ruff, pyright
- `backend/python/testing.md` - pytest, httpx
- `backend/python/async-patterns.md` - asyncio patterns
- `backend/python/lambdas.md` - Lambda packaging
- `backend/python/fastapi.md` - FastAPI, logging, config

**Infrastructure:**
- `infrastructure/terraform.md` - Terraform conventions
