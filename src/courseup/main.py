"""FastAPI application entry point.

Currently just a liveness endpoint. Real attendance-management routes land in
later feature PRs; this module exists so every quality gate has real code to
check from day one.
"""

from fastapi import FastAPI
from pydantic import BaseModel

app = FastAPI(title="CourseUp", version="0.1.0")


class HealthResponse(BaseModel):
    """Body returned by :func:`health`."""

    status: str


@app.get("/health")
def health() -> HealthResponse:
    """Liveness probe used by the Docker ``HEALTHCHECK`` and the CI smoke test."""
    return HealthResponse(status="ok")
