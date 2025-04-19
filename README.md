## LabRat v1.0

LabRat v1.0 is a super-charged, containerized AI playground built on the OpenAI Codex CLI.  
It bundles Python and Node ecosystems, headless browsers, vector databases, and AI tools into a single Docker launch.

Features:
- One-command launch (`./labrat`)
- Unified `config.yaml` for all API keys and service URLs
- Docker Compose with built-in Codex LabRat v1.0, Python tools, Chromium, and AI helpers
- Optional services: PostgreSQL, ChromaDB, Qdrant, OpenWebUI, Ollama
- Pre-installed Python & pip packages (OpenAI, HuggingFace, Selenium, FastAPI, etc.)
- Pre-installed Node & npm tools (Codex CLI, Playwright, Puppeteer, jsdom, browser-sync, etc.)

Quickstart (see `guide.md` for details):
1. Clone this repository:
   ```bash
   git clone https://github.com/YOUR_USERNAME/labrat.git
   cd labrat
   ```
2. Make the runner executable and run it:
   ```bash
   chmod +x labrat
   ./labrat
   ```
3. On first run, a `config.yaml` file will be created. Edit it to add your API keys:
   ```yaml
   openai_api_key: YOUR_OPENAI_API_KEY
   hf_api_token: YOUR_HUGGINGFACEHUB_API_TOKEN
   github_token: YOUR_GITHUB_TOKEN
   ```
4. Re-run the runner:
   ```bash
   ./labrat
   ```

This will:
1. Build and start a multi-service Docker environment
2. Launch the OpenAI Codex chat with “● OpenAI Codex LabRat v1.0” greeting
3. Give you a powerful AI CLI with access to browsers, vector DBs, and Python/Node tools

For full setup and customization, please read `guide.md`.

---
Credits:  
- Author: roBlock  
- Built on OpenAI Codex (https://github.com/openai/codex)  
- License: MIT