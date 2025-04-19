--------------------------------------------------
|       ___         _       _   _              __  |
|      | _ \\___  __| |___ _| |_(_)__  ___ ___ / _| |
|      |   / _ \\/ _` / -_) \\  / / _ \\/ -_) -_)  _| |
|      |_|_\\___/\\__,_\\___/_/_\\_\\_/_\\___\\___|_|   |
|                                                  |
|                   LabRat v1.0                    |
--------------------------------------------------

LabRat is a one-command AI coding assistant in Docker.
It preloads OS libraries, Python dependencies, and your system prompt.

Prerequisites
-------------
- Docker (version 20.10+)
- Docker Compose
- Git

Supported on Linux (Ubuntu/Debian), macOS, or Windows (WSL2).

Getting Started
---------------
1. Clone the repo:
     git clone https://github.com/roBlockweb/labrat.git
     cd labrat

2. Copy and fill in API keys:
     cp config.yaml.example config.yaml
     # Edit config.yaml with your OpenAI, Hugging Face, and GitHub tokens.

3. Add your system prompt:
     # Open system_prompt.txt and paste your LabRat prompt, then save.

4. Make the launcher script executable:
     chmod +x labrat.sh

5. Run LabRat:
     ./labrat.sh

What happens when you run the script
-------------------------------------
1. Builds the Docker image (OS packages and Python libraries).
2. Starts the LabRat container.
3. Copies your system_prompt.txt into the container.
4. Launches the Codex chat CLI with your system prompt loaded.

File Overview
-------------
- labrat.sh         Launcher script for Docker build & start.
- Dockerfile        Docker build instructions.
- docker-compose.yml Service definitions for LabRat container.
- requirements.txt  Python dependencies.
- system_prompt.txt Your AI assistant system prompt.
- config.yaml       Your API keys (ignored by Git).
- config.yaml.example Template for config.yaml.

Included Tools
--------------
- browser-use       CLI utility for browser interaction (https://github.com/browser-use/browser-use)

Config File (config.yaml)
--------------------------
Each line in config.yaml should follow YAML syntax:
openai_api_key: "<your OpenAI API key>"
hf_api_token:    "<your Hugging Face token>"
github_token:    "<your GitHub token>"
# Optional (leave blank or set URLs for custom services)
openwebui_url: "http://localhost:7860"
ollama_url:    "http://localhost:11434"
postgres_url:  "postgresql://postgres:pass@db:5432/labrat"
chromadb_url:  "http://chromadb:8000"
qdrant_url:    "http://qdrant:6333"

Troubleshooting
---------------
- If Docker is not found, install from https://docs.docker.com/get-docker/
- To rebuild after changing requirements.txt:
    docker-compose up --build

License
-------
MIT
