FROM python:3.12-slim

LABEL org.opencontainers.image.title="Podcast Generator"
LABEL org.opencontainers.image.description="Generates podcast feeds from YAML files"

RUN apt-get update && \
    apt-get install -y --no-install-recommends \
        git && \
    rm -rf /var/lib/apt/lists/*

RUN pip install --no-cache-dir PyYAML

WORKDIR /app

COPY feed.py /app/feed.py
COPY entrypoint.sh /app/entrypoint.sh

RUN chmod +x /app/entrypoint.sh

ENTRYPOINT ["/app/entrypoint.sh"]