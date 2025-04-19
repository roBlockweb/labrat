#===========================================+
#             LabRat v1.0 Guide             +
#===========================================+

           _              _       _   _   _
     _ __ | |__   __ _ __| | ___ | | | |_(_) ___  _ __
    | '_ \| '_ \ / _` / _` |/ _ \| | | __| |/ _ \| '_ \\
    | |_) | | | | (_| | (_| | (_) | | | |_| | (_) | | | |
    | .__/|_| |_|\__,_|\__,_|\___/|_|  \__|_|\___/|_| |_|
    |_|                                                 

Welcome to **LabRat v1.0**, your all-in-one AI playground powered by OpenAI Codex.
Follow these simple steps—even a 10-year-old can do it! 🎉

1. Clone the LabRat repo
   ```bash
   git clone https://github.com/roBlockweb/labrat.git
   cd labrat
   ```

2. Install Docker (must-have)
   - macOS: https://docs.docker.com/desktop/install/mac-install/
   - Windows: https://docs.docker.com/desktop/install/windows-install/
   - Linux: `sudo apt install docker.io docker-compose` or your distro’s package manager

3. Make the runner executable and start LabRat
   ```bash
   chmod +x labrat
   ./labrat
   ```
   - On first run, LabRat will:
     - Copy `config.yaml.example` → `config.yaml`
     - Ask you to open `config.yaml` and add keys/URLs
     - Exit so you can edit the file

4. Edit `config.yaml`
   Open it in any editor and fill in your keys:
   ```yaml
   openai_api_key: YOUR_OPENAI_API_KEY        # REQUIRED
   hf_api_token: YOUR_HUGGINGFACEHUB_API_TOKEN
   github_token: YOUR_GITHUB_TOKEN
   
   # Optional services (leave defaults if running in Docker)
   openwebui_url: http://localhost:3000
   ollama_url:    http://localhost:11434
   postgres_url:  postgresql://labrat:labrat@localhost:5432/labrat
   chromadb_url:  http://localhost:8000
   qdrant_url:    http://localhost:6333
   ```

5. Re-launch LabRat
   ```bash
   ./labrat
   ```
   LabRat will now:
     - Build and start Docker Compose (Codex chat + optional services)
     - Auto-install Python & Node tools inside the container
     - Launch the Codex chat interface with a friendly greeting

6. Enjoy your AI CLI!
   - You are now in the `codex chat` prompt
   - Ask questions or run commands; Codex has access to:
     - Headless Chromium (Playwright/Puppeteer)
     - Python libs: OpenAI, HuggingFace, Selenium, ChromaDB, Qdrant, FastAPI, etc.
     - Vector DBs: PostgreSQL, ChromaDB, Qdrant
     - AI UIs: OpenWebUI, Ollama endpoints

7. Stopping LabRat
   When done, exit chat (`Ctrl+D`), then:
   ```bash
   docker compose down
   ```

-----
_Tip:_ Explore `requirements.txt` for a full list of built-in dependencies.
Have fun, and happy AI hacking!