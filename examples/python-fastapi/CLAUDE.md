# Project: FastAPI Application
<!-- Example by Huzefa Nalkheda Wala | claude-code-optimizer -->

## Commands
- Dev: `uvicorn app.main:app --reload`
- Test: `pytest`
- Test single: `pytest tests/test_users.py -v`
- Lint: `ruff check .`
- Format: `ruff format .`
- Migrate: `alembic upgrade head`
- New migration: `alembic revision --autogenerate -m "description"`

## Entry Points
- app/main.py            → FastAPI app, router includes, middleware
- app/api/router.py      → All API routers mounted here (@claude-entry)
- app/core/config.py     → Settings from environment (pydantic-settings)
- app/db/session.py      → Database session factory
- alembic/env.py         → Migration configuration

## Request Flow
Client → FastAPI → Middleware (CORS, auth) → Router → Dependency Injection → Endpoint → Service → SQLAlchemy → PostgreSQL

## Key Decisions
- FastAPI not Django → async support, automatic OpenAPI, type hints
- SQLAlchemy 2.0 not raw SQL → type-safe queries, relationships
- Pydantic v2 for schemas → validation + serialization
- Alembic for migrations → standard with SQLAlchemy

## Conventions
- app/api/v1/endpoints/ → one file per resource
- app/models/ → SQLAlchemy models
- app/schemas/ → Pydantic request/response schemas
- app/services/ → Business logic
- app/core/deps.py → FastAPI dependencies (get_db, get_current_user)
- Tests mirror app/ structure in tests/
