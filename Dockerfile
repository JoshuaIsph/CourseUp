FROM python:3.13-slim

# uv, copied from its official image and pinned (Dependabot bumps the tag)
COPY --from=ghcr.io/astral-sh/uv:0.12.12 /uv /uvx /bin/

ENV UV_COMPILE_BYTECODE=1 \
    UV_LINK_MODE=copy \
    UV_NO_CACHE=1 \
    UV_PYTHON_DOWNLOADS=never

WORKDIR /app

# Dependencies first, as their own cache layer (no project, no dev deps)
COPY pyproject.toml uv.lock ./
RUN uv sync --frozen --no-install-project --no-dev

# Then the application (README is needed: pyproject points `readme` at it)
COPY README.md ./
COPY src ./src
RUN uv sync --frozen --no-dev

# Drop privileges
RUN useradd --create-home --uid 1000 app && chown -R app /app
USER app

ENV PATH="/app/.venv/bin:$PATH"
EXPOSE 8000

HEALTHCHECK --interval=30s --timeout=3s --start-period=5s --retries=3 \
    CMD python -c "import urllib.request; urllib.request.urlopen('http://localhost:8000/health').read()"

CMD ["uvicorn", "courseup.main:app", "--host", "0.0.0.0", "--port", "8000"]
