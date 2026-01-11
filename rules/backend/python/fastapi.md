---
paths: ["**/main.py", "**/app.py", "**/api/**/*.py", "**/routers/**/*.py"]
---

# FastAPI

## Framework
- Prefer FastAPI for AI applications

## Configuration
- Load `.env` with Pydantic `BaseSettings`
- Use `SettingsConfigDict(extra='ignore', case_sensitive=False)`
- Add field validators for required env vars

## Logging
- JSON logging via `python-json-logger`
