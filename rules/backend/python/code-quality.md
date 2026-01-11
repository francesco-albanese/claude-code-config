---
paths: ["**/*.py", "**/pyproject.toml", "**/ruff.toml"]
---

# Python Code Quality

## Tools
- **Type checking**: pyright (no `Any`, strict type hints)
- **Linting/Formatting**: ruff
- **Pre-commit**: prek (run typecheck, lint, format on commit)
- Run checks after every file write

## Code Style
- Follow Zen of Python (clarity > cleverness)
- Comments for "why", not "what"
- Strict type hints: TypedDict for structured Dicts, dataclasses for structured data containers
- Use singletons for stateless/immutable classes
