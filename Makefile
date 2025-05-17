#─────────────────────────────────────────────
#  Makefile — 30-Minute Lakehouse (Slim Edition)
#─────────────────────────────────────────────
SHELL          := bash
.DEFAULT_GOAL  := help
.ONESHELL:

# ───────────── 1. Help ───────────────────────
help:                 ## Show available targets
	@grep -E '^[a-zA-Z_-]+:.*?##' $(MAKEFILE_LIST) | \
	  awk 'BEGIN{FS=":.*?## "};{printf "  \033[36m%-18s\033[0m %s\n",$${1},$${2}}'

# ───────────── 2. CI YAML sync (developer only)
sync-ci:              ## Copy ci/workflows → .github/workflows
	@python3 scripts/sync_ci_block.py

# ───────────── 3. Terraform lint (local) ─────
lint:                 ## terraform fmt + validate
	terraform -chdir=infra init -backend=false -upgrade
	terraform -chdir=infra fmt -check -recursive
	terraform -chdir=infra validate -no-color

# ───────────── 4. Dev stack Up / Destroy ─────
#  Requires STATE_BUCKET / AWS_REGION env vars
define ensure_var
	@if [ -z "$($(1))" ]; then \
	  echo "❌  $(1) is not set. Export it or pass via 'make $@ $(1)=value'"; \
	  exit 1; \
	fi
endef

up destroy:           ## up = provision dev / destroy = tear-down dev
	$(call ensure_var,STATE_BUCKET)
	$(call ensure_var,AWS_REGION)

	@if ! aws s3 ls "s3://$(STATE_BUCKET)" --region $(AWS_REGION) 2>/dev/null; then \
	    echo "🪣  Creating state bucket: $(STATE_BUCKET)"; \
	    aws s3 mb "s3://$(STATE_BUCKET)" --region $(AWS_REGION); \
	    # (option) server-side encryption & versioning
	    aws s3api put-bucket-versioning \
	      --bucket $(STATE_BUCKET) --versioning-configuration Status=Enabled; \
	    aws s3api put-bucket-encryption \
	      --bucket $(STATE_BUCKET) \
	      --server-side-encryption-configuration \
	      '{"Rules":[{"ApplyServerSideEncryptionByDefault":{"SSEAlgorithm":"AES256"}}]}'; \
	fi

	terraform -chdir=infra init \
	  -backend-config="bucket=$(STATE_BUCKET)" \
	  -backend-config="key=ci/terraform.tfstate" \
	  -backend-config="region=$(AWS_REGION)" \
	  -backend-config="use_lockfile=true"

	terraform -chdir=infra workspace select dev \
	  || terraform -chdir=infra workspace new dev

	TF_VAR_prefix=starter-lh TF_VAR_env=dev \
	  terraform -chdir=infra $(if $(filter $@,up),apply,destroy) -auto-approve

# ───────────── 5. Athena smoke test ──────────
.PHONY: smoke          ## Run Athena smoke test
smoke:
	@bash pipelines/run_demo_queries.sh
