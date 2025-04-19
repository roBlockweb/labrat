FROM node:20-slim

RUN apt-get update && apt-get install -y \
    bash \
    curl \
    git \
    wget \
    unzip \
    sqlite3 \
    poppler-utils \
    build-essential \
    chromium-browser \
    chromium-driver \
    postgresql \
    postgresql-contrib \
    python3 \
    python3-venv \
    python3-pip \
    libpq-dev \
    libffi-dev \
    && rm -rf /var/lib/apt/lists/*

# Create Python virtual environment
RUN python3 -m venv /opt/venv
ENV PATH="/opt/venv/bin:$PATH"

# Copy and install Python package dependencies
COPY requirements.txt .
RUN pip install --no-cache-dir \
    openai \
    huggingface-hub \
    requests \
    python-dotenv \
    beautifulsoup4 \
    pdfplumber \
    langchain \
    llama-index \
    haystack \
    sentence-transformers \
    faiss-cpu \
    chromadb \
    openai-agents \
    transformers \
    psycopg2-binary \
    sqlalchemy \
    pandas \
    numpy \
    nltk

# Install Codex CLI globally and fix module path
RUN npm install -g @openai/codex && \
    ln -s /usr/local/lib/node_modules/@openai/codex/dist /usr/local/dist

# Patch the Codex CLI greeting
RUN SCRIPTPATH=$(which codex) && \
    sed -i 's/OpenAI Codex/OpenAI Codex LabRat v1.0/' "$SCRIPTPATH"

WORKDIR /workspace
## Keep container alive for exec
CMD ["tail", "-f", "/dev/null"]