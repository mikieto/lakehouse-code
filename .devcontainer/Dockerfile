FROM mcr.microsoft.com/devcontainers/base:jammy

RUN apt-get update && \
    # ---------- core packages ----------
    apt-get install -y --no-install-recommends \
        unzip curl python3-pip gnupg gh && \
    \
    # ---------- Python tools ----------
    pip install --no-cache-dir pre-commit \
        dbt-core==1.9.* dbt-duckdb dbt-athena-community && \
    \
    # ---------- tfsec ----------
    curl -sSL https://raw.githubusercontent.com/aquasecurity/tfsec/master/scripts/install_linux.sh | bash && \
    \
    # ---------- AWS CLI v2 ----------
    curl -sSL https://awscli.amazonaws.com/awscli-exe-linux-x86_64.zip -o aws.zip && \
    unzip -q aws.zip && ./aws/install && rm -rf aws aws.zip && \
    \
    # ---------- Terraform ----------
    curl -fsSL https://apt.releases.hashicorp.com/gpg | gpg --dearmor -o /usr/share/keyrings/hashicorp.gpg && \
    echo "deb [signed-by=/usr/share/keyrings/hashicorp.gpg] https://apt.releases.hashicorp.com $(lsb_release -cs) main" \
      > /etc/apt/sources.list.d/hashicorp.list && \
    apt-get update && apt-get install -y terraform && \
    \
    # ---------- Node 18 + markdownlint ----------
    curl -fsSL https://deb.nodesource.com/setup_18.x | bash - && \
    apt-get install -y nodejs && \
    npm i -g markdownlint-cli@0.40.0 && \
    ln -sf $(which node) /usr/local/bin/node && \
    \
    # ---------- cleanup ----------
    apt-get clean && rm -rf /var/lib/apt/lists/*
