#!/usr/bin/env bash
# Install VSCode extensions from scripts/vscode-extensions.txt.
# Skips comments and blank lines. Safe to re-run (code --install-extension is idempotent).
set -euo pipefail

EXTENSIONS_FILE="$(dirname "$0")/vscode-extensions.txt"

if ! command -v code >/dev/null; then
  echo "VSCode CLI not found. Open VSCode and run: Shell Command: Install 'code' command in PATH"
  exit 1
fi

grep -v '^\s*#' "$EXTENSIONS_FILE" | grep -v '^\s*$' | while read -r ext; do
  echo "Installing $ext..."
  code --install-extension "$ext" --force 2>/dev/null
done

echo "Done."
