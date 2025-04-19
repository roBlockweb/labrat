#!/usr/bin/env bash
set -e

# Entry point for LabRat Docker container
if [ ! -f /workspace/config.yaml ]; then
  echo "Config file not found. Copying example..."
  cp /workspace/config.yaml.example /workspace/config.yaml
  echo "Please edit 'config.yaml' and add your API keys."
  exit 1
fi

# Validate configuration before exporting keys
/usr/local/bin/validate_config.py /workspace/config.yaml

# Export API keys from config.yaml
export OPENAI_API_KEY=$(grep '^openai_api_key:' /workspace/config.yaml | awk -F': ' '{print $2}')
export HUGGINGFACEHUB_API_TOKEN=$(grep '^hf_api_token:' /workspace/config.yaml | awk -F': ' '{print $2}')
export GITHUB_TOKEN=$(grep '^github_token:' /workspace/config.yaml | awk -F': ' '{print $2}')
# Optional service URLs
export OPENWEBUI_URL=$(grep '^openwebui_url:' /workspace/config.yaml | awk -F': ' '{print $2}')
export OLLAMA_URL=$(grep '^ollama_url:' /workspace/config.yaml | awk -F': ' '{print $2}')
export POSTGRES_URL=$(grep '^postgres_url:' /workspace/config.yaml | awk -F': ' '{print $2}')
export CHROMADB_URL=$(grep '^chromadb_url:' /workspace/config.yaml | awk -F': ' '{print $2}')
export QDRANT_URL=$(grep '^qdrant_url:' /workspace/config.yaml | awk -F': ' '{print $2}')

# Health-check optional services before launching chat
if [ -n "$POSTGRES_URL" ]; then
  PG_HOST=$(echo "$POSTGRES_URL" | sed -E 's#^[^@]+@([^:/]+):.*#\1#')
  PG_PORT=$(echo "$POSTGRES_URL" | sed -E 's#.*:([0-9]+)/.*#\1#')
  echo "Waiting for Postgres at $PG_HOST:$PG_PORT..."
  until timeout 1 bash -c "cat < /dev/tcp/$PG_HOST/$PG_PORT" >/dev/null 2>&1; do sleep 2; done
fi
if [ -n "$CHROMADB_URL" ]; then
  echo "Waiting for ChromaDB at $CHROMADB_URL..."
  until curl -s --head --fail "$CHROMADB_URL"; do sleep 2; done
fi
if [ -n "$QDRANT_URL" ]; then
  echo "Waiting for Qdrant at $QDRANT_URL..."
  until curl -s --head --fail "$QDRANT_URL"; do sleep 2; done
fi
if [ -n "$OPENWEBUI_URL" ]; then
  echo "Waiting for OpenWebUI at $OPENWEBUI_URL..."
  until curl -s --head --fail "$OPENWEBUI_URL"; do sleep 2; done
fi
if [ -n "$OLLAMA_URL" ]; then
  echo "Waiting for Ollama at $OLLAMA_URL..."
  until curl -s --head --fail "$OLLAMA_URL"; do sleep 2; done
fi

# Launch the interactive Codex chat with retry logic
echo "Starting Codex chat. Use Ctrl+D to exit any time."
exec codex-chat-rat.sh