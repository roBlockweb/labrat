FROM node:18-slim

RUN apt-get update && apt-get install -y \
    bash curl git python3 python3-venv python3-pip build-essential libffi-dev && \
    rm -rf /var/lib/apt/lists/*

# Create Python virtual environment
RUN python3 -m venv /opt/venv
ENV PATH="/opt/venv/bin:$PATH"

# Install Python packages
RUN pip install --no-cache-dir \
    openai \
    huggingface-hub \
    requests \
    python-dotenv

# Install Codex CLI globally and fix module path
RUN npm install -g @openai/codex && \
    ln -s /usr/local/lib/node_modules/@openai/codex/dist /usr/local/dist

# Patch the Codex CLI greeting
RUN SCRIPTPATH=$(which codex) && \
    sed -i 's/OpenAI Codex/OpenAI Codex LabRat v1.0/' "$SCRIPTPATH"

WORKDIR /workspace
## Keep container alive for exec
CMD ["tail", "-f", "/dev/null"]