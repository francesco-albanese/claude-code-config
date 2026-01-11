# Python Coding Style Guide

## Core Principles

- Pythonic code following Zen of Python
- Explicit over implicit
- Easy to understand without comments
- Comments only for "why", never "what"
- Strict type hints (mypy strict mode)

## Type Hints

```python
# Modern union syntax
def get_user(user_id: str | None = None) -> dict[str, str] | None:
    pass

# Generic types
items: list[str] = []
mapping: dict[str, int] = {}
data: set[int] = set()

# Never use typing.Optional, typing.List, typing.Dict
# ❌ from typing import Optional, List
# ✅ str | None, list[str]
```

## Data Structures

### TypedDict for structured dicts

```python
from typing import TypedDict

class OperationMetadata(TypedDict):
    method: str
    endpoint: str
    body: dict
    connection_name: str
    connection_id: int
```

### Dataclasses for data containers

```python
from dataclasses import dataclass

@dataclass
class Config:
    host: str
    port: int
    timeout: float = 30.0
```

### Pydantic v2 for validation

```python
from pydantic import BaseModel, Field, field_validator, ConfigDict

class User(BaseModel):
    model_config = ConfigDict(str_strip_whitespace=True)

    name: str = Field(..., min_length=1)
    age: int = Field(..., gt=0)

    @field_validator("name")
    @classmethod
    def validate_name(cls, v: str) -> str:
        if not v.strip():
            raise ValueError("name cannot be empty")
        return v
```

### Pydantic Settings for env vars

```python
from pydantic import Field, FilePath
from pydantic_settings import BaseSettings, SettingsConfigDict

class EnvVars(BaseSettings):
    model_config = SettingsConfigDict(
        env_file=".env",
        case_sensitive=False,
        extra="ignore"
    )

    api_url: str = Field(..., description="API base URL")
    config_file: FilePath = Field(..., description="Config path")

    @field_validator("api_url")
    @classmethod
    def validate_url(cls, v: str) -> str:
        if not v.startswith("https://"):
            raise ValueError(f"URL must use HTTPS: {v}")
        return v if v.endswith("/") else f"{v}/"

ENV_VARS = EnvVars()
```

## Async Programming

### Async functions for I/O

```python
async def fetch_data(url: str) -> dict:
    async with aiohttp.ClientSession() as session:
        async with session.get(url) as response:
            return await response.json()
```

### Async context managers

```python
class AIOHttpClient:
    async def __aenter__(self) -> "AIOHttpClient":
        self.session = ClientSession(self.base_url)
        return self

    async def __aexit__(self, exc_type, exc_val, exc_tb) -> None:
        if self.session:
            await self.session.close()
```

### Concurrency control with semaphore

```python
import asyncio

class BaseOperation:
    def __init__(self, max_concurrent: int = 50) -> None:
        self.semaphore = asyncio.Semaphore(max_concurrent)

    async def execute(self) -> None:
        async with self.semaphore:
            await self._do_work()
```

### Parallel execution

```python
tasks = [
    fetch_user(user_id)
    for user_id in user_ids
]
results = await asyncio.gather(*tasks)
```

### Clear error messages

```python
if value <= 0:
    raise ValueError(f"connection_id must be positive, got: {value}")

if env_name not in valid_envs:
    raise ValueError(
        f"Invalid environment: {env_name}. "
        f"Valid values: {', '.join(valid_envs)}"
    )
```

### CLI error handling

```python
import sys

if not is_valid():
    print(
        f"ERROR: Invalid configuration.\n"
        f"Expected format: config.{{env}}.json\n"
        f"Got: {filename}",
        file=sys.stderr
    )
    sys.exit(1)
```

## Logging

### Structured JSON logging

````python
import logging
from pythonjsonlogger.json import JsonFormatter

class StructuredLogger:
    @staticmethod
    def get_logger(name: str = "app", log_level: str = "INFO") -> logging.Logger:
        logger = logging.getLogger(name)
        logger.setLevel(log_level)

        if not logger.handlers:
            handler = logging.StreamHandler()
            fmt = "%(asctime)s %(levelname)s %(filename)s %(funcName)s %(lineno)d %(message)s"
            handler.setFormatter(JsonFormatter(fmt))
            logger.addHandler(handler)

        return logger

json_logger = StructuredLogger.get_logger()

## Abstract Base Classes
```python
from abc import ABC, abstractmethod

class BaseOperation(ABC):
    @abstractmethod
    async def execute_all(self, client: AIOHttpClient) -> None:
        pass

    @abstractmethod
    def dry_run_operations(self) -> list[dict]:
        pass
````

## FastAPI Patterns

### Async route handlers

```python
from fastapi import FastAPI, HTTPException, Depends
from pydantic import BaseModel, Field

app = FastAPI()

class CreateUserRequest(BaseModel):
    name: str = Field(..., min_length=1)
    email: str = Field(..., pattern=r"^[\w\.-]+@[\w\.-]+\.\w+$")

class UserResponse(BaseModel):
    id: int
    name: str
    email: str

@app.post("/users", response_model=UserResponse)
async def create_user(request: CreateUserRequest) -> UserResponse:
    user = await user_service.create(request.name, request.email)
    return UserResponse(id=user.id, name=user.name, email=user.email)

@app.get("/users/{user_id}", response_model=UserResponse)
async def get_user(user_id: int) -> UserResponse:
    user = await user_service.get_by_id(user_id)
    if not user:
        raise HTTPException(status_code=404, detail=f"User {user_id} not found")
    return UserResponse(id=user.id, name=user.name, email=user.email)
```

### Dependency injection

```python
from fastapi import Depends
from typing import Annotated

async def get_db_session() -> AsyncSession:
    async with async_session() as session:
        yield session

async def get_current_user(
    token: str = Depends(oauth2_scheme),
    db: AsyncSession = Depends(get_db_session)
) -> User:
    user = await user_service.get_by_token(token, db)
    if not user:
        raise HTTPException(status_code=401, detail="Invalid token")
    return user

@app.get("/me")
async def get_me(
    current_user: Annotated[User, Depends(get_current_user)]
) -> UserResponse:
    return UserResponse.from_orm(current_user)
```

## Package Management

### uv with pyproject.toml

```toml
[project]
name = "myapp"
version = "0.1.0"
requires-python = ">=3.13"
dependencies = []

[dependency-groups]
dev = [
    "aiohttp==3.13.1",
    "boto3==1.40.32",
    "fastapi==0.115.0",
    "pydantic==2.11.9",
    "pydantic-settings==2.10.1",
    "pytest==8.4.2",
    "ruff==0.13.0",
    "uvicorn==0.32.0",
]
```

### Virtual environment workflow

```bash
# Create venv
uv venv --python 3.13

# Install deps
uv sync --dev

# Run script
uv run python -m myapp

# Add dependency
uv add fastapi
```

## Make Automation

```makefile
.PHONY: install check test run

install: ## Install dependencies
	uv sync --dev

check: ## Run linting
	uv run ruff check .
	uv run mypy .

test: ## Run tests
	uv run pytest tests/

run: ## Run application
	uv run uvicorn app.main:app --reload

help: ## Show help
	@awk 'BEGIN {FS = ":.*##"; printf "Usage:\n  make <target>\n\nTargets:\n"} \
	/^[a-zA-Z_-]+:.*##/ { printf "  \033[32m%-15s\033[0m %s\n", $$1, $$2 }' $(MAKEFILE_LIST)
```
