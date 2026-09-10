"""A plain (non-async) unit test, so the fast test path and coverage wiring
are both exercised even before real domain code exists."""

from courseup import __version__


def test_version_is_semver_ish() -> None:
    assert isinstance(__version__, str)
    assert __version__.count(".") == 2
