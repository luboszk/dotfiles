#!/usr/bin/env bash
# Register this machine's SSH public key as a signing key on GitHub.
# Run once per machine after bootstrap.
set -euo pipefail

# Find SSH public key — prefer ed25519, fall back to rsa
if [[ -f ~/.ssh/id_ed25519.pub ]]; then
  KEY=~/.ssh/id_ed25519.pub
elif [[ -f ~/.ssh/id_rsa.pub ]]; then
  KEY=~/.ssh/id_rsa.pub
else
  echo "No SSH public key found at ~/.ssh/id_ed25519.pub or ~/.ssh/id_rsa.pub"
  echo "Generate one with: ssh-keygen -t ed25519 -C \"$(git config user.email)\""
  exit 1
fi

# Check gh is authenticated
if ! gh auth status >/dev/null 2>&1; then
  echo "Not logged into GitHub CLI. Run: gh auth login"
  exit 1
fi

# Ensure the admin:ssh_signing_key scope is granted (not included in default login)
gh auth refresh -h github.com -s admin:ssh_signing_key

TITLE="${1:-$(hostname -s)}"

echo "Adding $KEY as a signing key on GitHub (title: $TITLE)..."
gh ssh-key add "$KEY" --type signing --title "$TITLE"
echo "Done. Commits from this machine will show 'Verified' on GitHub."
echo ""
echo "Make sure this key is also loaded in your SSH agent:"
echo "  ssh-add --apple-use-keychain $KEY"
