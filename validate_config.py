#!/usr/bin/env python3
"""
Simple YAML config validator for LabRat v1.0
Checks required API keys and validates optional service URLs.
"""
import sys
from urllib.parse import urlparse

try:
    import yaml
except ImportError:
    print("PyYAML is required: pip install pyyaml", file=sys.stderr)
    sys.exit(1)

def main(path):
    try:
        with open(path) as f:
            cfg = yaml.safe_load(f)
    except Exception as e:
        print(f"Error reading config file '{path}': {e}", file=sys.stderr)
        sys.exit(1)

    required = ['openai_api_key', 'hf_api_token', 'github_token']
    optional_urls = [
        'openwebui_url', 'ollama_url',
        'postgres_url', 'chromadb_url', 'qdrant_url'
    ]
    errors = []

    for key in required:
        v = cfg.get(key)
        if not v or not isinstance(v, str):
            errors.append(f"Missing required '{key}' in config.")

    for key in optional_urls:
        v = cfg.get(key)
        if v:
            try:
                parsed = urlparse(v)
                if not parsed.scheme or not parsed.netloc:
                    errors.append(f"Invalid URL in '{key}': {v}")
            except Exception:
                errors.append(f"Invalid URL in '{key}': {v}")

    if errors:
        print("Config validation errors:", file=sys.stderr)
        for err in errors:
            print(f"  - {err}", file=sys.stderr)
        sys.exit(1)
    print("Config validation passed.")

if __name__ == '__main__':
    if len(sys.argv) < 2:
        print("Usage: validate_config.py <path to config.yaml>", file=sys.stderr)
        sys.exit(1)
    main(sys.argv[1])