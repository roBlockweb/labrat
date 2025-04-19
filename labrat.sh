#!/usr/bin/env bash
set -e

# Check Docker
if ! command -v docker >/dev/null 2>&1; then
  echo "Please install Docker"
  exit 1
fi

# Check config file
if [ ! -f config.yaml ]; then
  echo "config.yaml not found. Copy and fill keys."
  exit 1
fi

# Export variables from config.yaml
for key in openai_api_key hf_api_token github_token openwebui_url ollama_url postgres_url chromadb_url qdrant_url; do
  val=$(grep "^$key:" config.yaml | awk -F": " '{print $2}' | sed 's/^"//;s/"$//')
  case "$key" in
    hf_api_token) name=HUGGINGFACEHUB_API_TOKEN;;
    *) name=$(echo "$key" | tr '[:lower:]' '[:upper:]');;
  esac
  export $name="$val"
done

# Build and start container
docker-compose up --build --remove-orphans -d

# Copy system prompt into container
docker cp system_prompt.txt labrat:/system_prompt.txt

echo "Launching LabRat CLI..."
exec docker-compose exec labrat codex chat --system-prompt-file /system_prompt.txt
