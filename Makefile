.PHONY: deploy-foundation
deploy-foundation:
	terraform -chdir=infra init -backend=false
