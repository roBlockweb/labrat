#!/usr/bin/env bash
# Retry loop for `codex chat` sessions (Codex Chat Rat)
set -e

# Delay before retrying (in seconds)
RETRY_DELAY=5

while true; do
    codex chat
    rc=$?
    if [ $rc -eq 0 ]; then
        exit 0
    fi
    echo "codex chat exited with code $rc."
    echo -n "Retry session? [y/N] "
    read -r answer
    case "$answer" in
        [Yy]* )
            echo "Retrying in $RETRY_DELAY seconds..."
            sleep $RETRY_DELAY
            ;;
        * )
            echo "Exiting."
            exit $rc
            ;;
    esac
done