.PHONY: install lint format typecheck test test-fast check run docker-build

install:  ## Install deps and git hooks
	uv sync
	uv run pre-commit install

lint:  ## Ruff lint + format check (no changes)
	uv run ruff check .
	uv run ruff format --check .

format:  ## Ruff auto-fix + format
	uv run ruff check --fix .
	uv run ruff format .

typecheck:  ## mypy --strict
	uv run mypy

test:  ## Full test suite + coverage
	uv run pytest

test-fast:  ## Tests not marked `slow`
	uv run pytest -m "not slow"

check: lint typecheck test  ## The full local gate (same as CI)

run:  ## Run the API locally with autoreload
	uv run uvicorn courseup.main:app --reload

docker-build:  ## Build the container image
	docker build -t courseup:local .
