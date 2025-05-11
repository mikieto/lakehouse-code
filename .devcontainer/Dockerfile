FROM mcr.microsoft.com/devcontainers/base:jammy

# Essentials
RUN apt-get update && \
    apt-get install -y --no-install-recommends \
      unzip curl python3-pip && \
    rm -rf /var/lib/apt/lists/*

# CLI tools
RUN pip install --no-cache-dir pre-commit \
    && curl -sSL https://awscli.amazonaws.com/awscli-exe-linux-x86_64.zip -o aws.zip \
    && unzip -q aws.zip && ./aws/install && rm -rf aws aws.zip

# Data stack
RUN pip install --no-cache-dir \
      pyspark==3.5.* \
      dbt-core==1.9.*

# Terraform
RUN curl -fsSL https://apt.releases.hashicorp.com/gpg | gpg --dearmor -o /usr/share/keyrings/hashicorp.gpg && \
    echo "deb [signed-by=/usr/share/keyrings/hashicorp.gpg] https://apt.releases.hashicorp.com $(lsb_release -cs) main" \
    | tee /etc/apt/sources.list.d/hashicorp.list && \
    apt-get update && apt-get install -y terraform && rm -rf /var/lib/apt/lists/*
