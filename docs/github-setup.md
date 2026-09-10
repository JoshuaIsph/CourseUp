# One-time GitHub setup

These are the repo settings that can't live in code. Do them once.

## 1. Claude review secret

- Run `claude setup-token` locally (Pro/Max subscription account).
- Copy the `sk-ant-oat01-...` value from the **terminal** (not the browser page).
- Repo → Settings → Secrets and variables → Actions → New repository secret
  - Name: `CLAUDE_CODE_OAUTH_TOKEN`
  - Value: the token
- Re-run and re-set if CI later fails with an auth error (the token can expire).

## 2. Code security

Settings → Code security:

- Enable **Secret scanning**
- Enable **Push protection**
- Confirm **Dependabot alerts** and **Dependabot security updates** are on

## 3. Pull request defaults

Settings → General → Pull Requests:

- Tick **Allow squash merging**, untick merge commits and rebase
- Tick **Automatically delete head branches**

## 4. Branch protection

Let CI go green once first so you know the check name (`check`).

Settings → Branches → Add branch ruleset (target `main`):

- Require a pull request before merging (0 approvals — solo)
- Require status checks to pass → add `check`
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
