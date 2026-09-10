# One-time GitHub setup

Repo settings that can't live in code. Do them once.

## 1. Code security

Settings → Code security:

- Enable **Secret scanning**
- Enable **Push protection**
- Confirm **Dependabot alerts** and **Dependabot security updates** are on

## 2. Pull request defaults

Settings → General → Pull Requests:

- Tick **Allow squash merging**; untick merge commits and rebase
- Tick **Automatically delete head branches**

## 3. Branch protection

Let CI go green on `main` once first, so the check name (`check`) is known.

Settings → Branches → Add branch ruleset (target `main`):

- Require a pull request before merging (0 approvals — solo dev)
- Require status checks to pass → add **`check`**
- Require branches to be up to date before merging
- Require linear history
- Block force pushes
- Restrict deletions

## Everyday flow after this

```bash
git switch -c my-change
# edit, commit
git push -u origin my-change
gh pr create --fill
gh pr merge --auto --squash
```

## Not set up (deliberately)

- **CodeQL** — needs GitHub Advanced Security on private repos. Replaced by
  `pip-audit` + Ruff's `S` rules + Trivy in CI. Revisit if the repo goes public.
- **Claude PR review Action** — the `claude setup-token` OAuth path returned
  `401 Invalid bearer token` in Actions on this Pro plan. Options if you want it
  later: use a pay-as-you-go `ANTHROPIC_API_KEY` secret with
  `anthropics/claude-code-action`, or upgrade to Claude Max. For now, review
  locally with `/code-review` and `/security-review` before merging.
