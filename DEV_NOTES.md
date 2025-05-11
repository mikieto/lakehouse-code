
# 2025-05-12 — Phase B hard-freeze preparations

- **Docs sync**: README, `docs/plan.md`, and `lakehouse-book/00_project_plan.md` now share the same BEGIN/END exit-criteria block.  
- **DevContainer**: Dockerfile ships Node 18, `markdownlint-cli 0.40.0`, and GitHub CLI; `devcontainer.json` switched to the built image (`ghcr.io/.../lakehouse-code:latest`).  
- **Pre-commit**: Node 18 is used as system runtime; gitlint/markdownlint/vale all pass.  
- **Guard CI**:  
  - `guard-pr` (label gate) unchanged.  
  - New `guard-main` job runs on every push to **main**.  
  - Main branch now shows three consecutive green runs (Exit #3).  
- **Smoke CI**: Added `push@main` trigger and `timeout-minutes: 20`.  
- **Roadmap**: Timeline bumped to **Sprint S-1** (AWS Serverless “≤ 30 min deploy”).  
- **Next steps**: push the `phase-b-complete` tag + release, then start `feat/s1-serverless-deploy`.

# 2025-05-09 Cleanup

- Removed legacy workflows: build-push.yml, ci.yml

# Phase A – Manual Bootstrap (2025-05-08)

| Step            | Done | Notes                                          |
|-----------------|------|------------------------------------------------|
| README + Badge  | ✔    | Replaced `<org>` ; Guard badge is green        |
| docs/3-files    | ✔    | Committed empty placeholder files              |
| Labels          | ✔    | Added labels: environment:s3 / norm:security   |
| guard.yml       | ✔    | Confirmed echo-only workflow runs successfully |
| PR→CI→Merge     | ✔    | Guard green, merged into main                  |
| Time spent      | ??   | Record the actual time spent                   |
