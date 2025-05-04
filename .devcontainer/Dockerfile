FROM python:3.12-slim
ENV DEBIAN_FRONTEND=noninteractive
WORKDIR /workspace

# Common tools for all images
RUN apt-get update && \
    apt-get install -y --no-install-recommends \
        git curl build-essential ruby-full pandoc && \
    rm -rf /var/lib/apt/lists/*

# Markdownlint
RUN pip install -q \
        dbt-duckdb dbt-spark "pyspark==3.5.*" delta-spark \
        pre-commit && \
    gem install --no-document mdl

# Vale
RUN curl -sSL https://github.com/errata-ai/vale/releases/download/v3.0.2/vale_3.0.2_Linux_64-bit.tar.gz \
    | tar -xz -C /usr/local/bin --strip-components=1 vale

# act
RUN curl -s https://raw.githubusercontent.com/nektos/act/master/install.sh | bash
