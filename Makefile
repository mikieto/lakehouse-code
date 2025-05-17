#─────────────────────────────────────────────────────────────
#  Makefile — Starter-Lakehouse (Golden Template v1)
#─────────────────────────────────────────────────────────────
SHELL := bash
.DEFAULT_GOAL := help
.ONESHELL:

# -------- Variables ----------------------------------------------------
TF_DIR        ?= infra
VENDOR_DIR    ?= $(TF_DIR)/_vendor
MODULE_NAME   ?= example_module          # new-module target
COOKIECUTTER  := cookiecutter-golden-terraform-module

# Terraform remote-state config (must be exported or passed inline)
STATE_BUCKET  ?=
LOCK_TABLE    ?=
AWS_REGION    ?=

# -------- Guard: ensure variables are set ------------------------------
define check_var
	@if [ -z "$($(1))" ]; then \
	  echo "❌  $(1) is not set. Export it or pass via 'make $@ $(1)=value'"; \
	  exit 1; \
	fi
endef

# -------- Help ---------------------------------------------------------
.PHONY: help
help:      ## Show available targets
	@grep -E '^[a-zA-Z_-]+:.*?##' $(MAKEFILE_LIST) | \
	    awk 'BEGIN {FS = ":.*?## "}; {printf "  \033[36m%-22s\033[0m %s\n", $$1, $$2}'

# -------- CI Sync ------------------------------------------------------
.PHONY: sync-ci
sync-ci:   ## Copy ci/workflows → .github/workflows
	@python3 scripts/sync_ci_block.py

# -------- Terraform (local) --------------------------------------------
.PHONY: tf-init tf-fmt tf-validate tf-plan
tf-init:   ## terraform init (local backend)
	terraform -chdir=$(TF_DIR) init -upgrade -backend=false

tf-fmt:    ## terraform fmt (check only)
	terraform -chdir=$(TF_DIR) fmt -check -recursive

tf-validate: ## terraform validate
	terraform -chdir=$(TF_DIR) validate -no-color

tf-plan:   ## terraform plan (local)
	terraform -chdir=$(TF_DIR) plan -no-color

# -------- Bundle (offline ZIP) ----------------------------------------
.PHONY: bundle
bundle:    ## Vendor modules & create starter-lakehouse.zip
	@echo "📦  Vendoring modules → $(VENDOR_DIR)"
	@rm -rf $(VENDOR_DIR) && mkdir -p $(VENDOR_DIR)
	terraform -chdir=$(TF_DIR) init -backend=false -upgrade
	cp -R $(TF_DIR)/.terraform/modules/* $(VENDOR_DIR)/
	sed -i 's#source *= *"github.com/.*/\(.*\)#source = "./_vendor/\1"#' $(TF_DIR)/*.tf
	git archive --prefix=starter-lakehouse/ -o starter-lakehouse.zip HEAD
	@echo "✅  Bundle ready: starter-lakehouse.zip"

# -------- New Terraform Module ----------------------------------------
.PHONY: new-module
new-module: ## cookiecutter scaffold for MODULE_NAME=<name>
	@echo "🆕  Scaffolding module: $(MODULE_NAME)"
	@cookiecutter $(COOKIECUTTER) --no-input module_name=$(MODULE_NAME)

# -------- Lint ---------------------------------------------------------
.PHONY: lint
lint: tf-fmt tf-validate ## Run minimal lint suite (fmt + validate)

# -------- Clean --------------------------------------------------------
.PHONY: clean
clean:    ## Remove .terraform & vendor cache
	rm -rf $(TF_DIR)/.terraform $(VENDOR_DIR)

# -------- Remote Dev Stack --------------------------------------------
.PHONY: up destroy
up:      ## Provision dev workspace (remote backend)
	$(call check_var,STATE_BUCKET)
	$(call check_var,LOCK_TABLE)
	$(call check_var,AWS_REGION)
	terraform -chdir=$(TF_DIR) init \
	   -backend-config="bucket=$(STATE_BUCKET)" \
	   -backend-config="key=ci/terraform.tfstate" \
	   -backend-config="region=$(AWS_REGION)" \
	   -backend-config="use_lockfile=true"
	terraform -chdir=$(TF_DIR) workspace select dev || terraform -chdir=$(TF_DIR) workspace new dev
	TF_VAR_prefix=starter-lh TF_VAR_env=dev \
	  terraform -chdir=$(TF_DIR) apply -auto-approve

destroy: ## Destroy dev workspace (remote backend)
	$(call check_var,STATE_BUCKET)
	$(call check_var,LOCK_TABLE)
	$(call check_var,AWS_REGION)
	terraform -chdir=$(TF_DIR) init \
	   -backend-config="bucket=$(STATE_BUCKET)" \
	   -backend-config="key=ci/terraform.tfstate" \
	   -backend-config="region=$(AWS_REGION)" \
	   -backend-config="use_lockfile=true"
	terraform -chdir=$(TF_DIR) workspace select dev
	TF_VAR_prefix=starter-lh TF_VAR_env=dev \
	  terraform -chdir=$(TF_DIR) destroy -auto-approve
# -----------------------------------------------------------------------
# End of file
# -----------------------------------------------------------------------
