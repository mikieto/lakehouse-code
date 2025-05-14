.PHONY: sync-ci

## sync-ci: copy reusable workflows into .github/workflows
sync-ci:
	@python3 scripts/sync_ci_block.py

