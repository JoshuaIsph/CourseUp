# CourseUp

Attendance management app for a small business. FastAPI service, Python 3.13.

**Proprietary — All rights reserved.** Not licensed for use, copying, or distribution.

## Prerequisites

- [uv](https://docs.astral.sh/uv/) — `brew install uv`
- [GitHub CLI](https://cli.github.com/) — `brew install gh` (for the PR workflow)
- Docker — for the container build / smoke test

## Setup

```bash
uv sync                     # create .venv, install runtime + dev deps
uv run pre-commit install   # install the pre-commit + pre-push git hooks
```

## Everyday commands

These are exactly what CI runs — see the `Makefile`.

| Command | Does |
| --- | --- |
| `make check` | lint + typecheck + tests — the full local gate |
| `make lint` | Ruff lint + format check |
| `make format` | Ruff auto-fix + format |
| `make typecheck` | `mypy --strict` |
| `make test` | pytest, full suite + coverage |
| `make test-fast` | pytest, skipping `slow` |
| `make run` | run the API at http://localhost:8000 |
| `make docker-build` | build the container image |

## Layout

```
src/courseup/   application code
tests/          pytest tests, mirroring src/
```

## Workflow

`main` is protected — every change goes through a pull request:

```bash
git switch -c my-change
# edit, commit
git push -u origin my-change
gh pr create --fill
gh pr merge --auto --squash   # merges once all checks pass
```

CI (lint, types, tests, Docker build + smoke test, dependency + image CVE scan)
and an automated Claude review run on every PR.
