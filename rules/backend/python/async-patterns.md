---
paths: ["**/*.py"]
---

# Python Async Patterns

## asyncio
- Prefer `asyncio.TaskGroup` over `asyncio.gather`
- Per-task try/except for non-critical requests
- Avoid `gather(..., return_exceptions=True)` unless logging/retry needed
