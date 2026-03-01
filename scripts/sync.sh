#!/usr/bin/env bash
set -euo pipefail

REPO_DIR="$(cd "$(dirname "$0")/.." && pwd)"

cd "$REPO_DIR"

case "${1:-}" in
  push)
    git add .
    git commit -m "${2:-update}"
    git push
    ;;
  pull)
    git pull
    ;;
  *)
    echo "Usage: ./scripts/sync.sh {push [msg]|pull}"
    exit 1
    ;;
esac
