FROM node:18-alpine

# Install system packages and utilities
RUN apk add --no-cache bash curl git python3 py3-pip openjdk11-jre chromium chromium-chromedriver build-base libffi-dev

# Install Python packages
RUN pip3 install --no-cache-dir \
    openai \
    huggingface-hub \
    selenium \
    requests \
    chromadb \
    qdrant-client \
    fastapi \
    uvicorn \
    beautifulsoup4 \
    python-dotenv \
    pyyaml

# Install Node packages globally (Codex CLI, browser tools, AI helpers)
RUN npm install -g \
    @openai/codex \
    playwright \
    puppeteer \
    jsdom \
    browser-sync \
    mcp

# Patch the Codex CLI greeting to reflect LabRat v1.0
RUN SCRIPTPATH=$(which codex) \
    && sed -i 's/OpenAI Codex/OpenAI Codex LabRat v1.0/' "$SCRIPTPATH"

# Copy validation script and chat wrapper
# Copy configuration validator and chat retry tool
COPY validate_config.py /usr/local/bin/validate_config.py
COPY codex-chat-rat.sh /usr/local/bin/codex-chat-rat.sh
RUN chmod +x /usr/local/bin/validate_config.py /usr/local/bin/codex-chat-rat.sh

# Copy entrypoint script
COPY entrypoint.sh /usr/local/bin/entrypoint.sh
RUN chmod +x /usr/local/bin/entrypoint.sh

WORKDIR /workspace

# Entrypoint
ENTRYPOINT ["entrypoint.sh"]