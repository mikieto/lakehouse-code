.PHONY: up nuke
up:    ; ./scripts/quick_start.sh --deploy
nuke:  ; ./scripts/quick_start.sh --nuke

.PHONY: sync-docs
## sync-docs: keep EXIT_CRITERIA block in sync across docs
sync-docs:
	@python3 scripts/sync_exit_block.py
