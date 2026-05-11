# dotfiles

macOS dotfiles for platform engineering. Managed with [GNU Stow](https://www.gnu.org/software/stow/). Works on Intel and Apple Silicon.

## Bootstrap

```sh
git clone git@github.com:luboszkosnik/dotfiles.git ~/dotfiles
cd ~/dotfiles
./scripts/bootstrap.sh
```

The script installs Xcode CLT, Homebrew, all tools via `Brewfile`, sets up tmux plugins, bat themes, and runs `stow .` to link everything.

## What's included

| Layer | Tool |
|---|---|
| Terminal | [WezTerm](https://wezfurlong.org/wezterm/) |
| Multiplexer | tmux + TPM |
| Shell | zsh + [zinit](https://github.com/zdharma-continuum/zinit) + [Starship](https://starship.rs/) |
| Window manager | [Aerospace](https://github.com/nikitabobko/AeroSpace) |
| Editor (primary) | VSCode — configured via built-in Settings Sync |
| Editor (secondary) | Neovim + [NvChad](https://nvchad.com/) |
| Git diffs | [delta](https://github.com/dandavison/delta) side-by-side |
| File explorer | [yazi](https://github.com/sxyazi/yazi) |

## Platform engineering tools

Installed via Brewfile:

```
gh            GitHub CLI + gh-dash extension
awscli        AWS CLI
granted       AWS SSO role picker + sso populate (auto-discovers all accounts)
tenv          Terraform version switcher (reads .terraform-version per repo)
tflint        Terraform linter
terraform-docs  Auto-generate module docs
trivy         IaC + container vuln scanning
kubectl       Kubernetes CLI
helm          Kubernetes package manager
k9s           TUI for Kubernetes
kubectx/ns    Switch clusters and namespaces
stern         Multi-pod log tailer
kustomize     Kubernetes overlays
colima        Container runtime (docker-compatible)
docker        Docker CLI
lazydocker    TUI for docker
direnv        Per-directory env vars
sops + age    Secret encryption
act           Run GitHub Actions locally
```

## Version management

| Tool | Manager | Single source of truth |
|---|---|---|
| Terraform | `tenv` | `.terraform-version` per repo |
| Go | `GOTOOLCHAIN=auto` (built-in) | `toolchain` directive in `go.mod` |
| Python | `uv` | `pyproject.toml` / `.python-version` |
| Node, Java, etc. | `mise` | `.mise.toml` per repo |

### Python (uv) — no virtualenv nonsense

```sh
uv init my-project        # scaffold pyproject.toml
uv add requests           # install dep into auto-managed .venv
uv run main.py            # runs in .venv automatically — no activate
uv tool install ruff      # global CLI, isolated
```

### Terraform (tenv)

```sh
tenv tf install latest           # install latest
tenv tf install 1.5.7            # install specific version
# In a repo: add .terraform-version, tenv handles the rest
```

### AWS SSO (granted) — one-time per machine

```sh
granted sso login --sso-region <region> --start-url https://<org>.awsapps.com/start
granted sso populate --sso-region <region> --start-url https://<org>.awsapps.com/start
# Day-to-day:
assume                     # interactive picker
assume <profile-name>      # jump straight in
assume -c                  # open AWS Console in browser
```

## Profile system (personal vs work)

Set `DOTFILES_PROFILE=work` in `~/.zshenv` on the work machine. This switches:

- **Secrets backend:** work → 1Password CLI (`op`), personal → macOS Keychain
- **Git identity:** repos under `~/work/` automatically get the work email via `includeIf` in `.gitconfig`

### Adding a secret

**Personal (Keychain):**
```sh
security add-generic-password -a "$USER" -s MY_SECRET_KEY -w '<value>'
# Then source it in ~/.secrets.local or add to the loader in dot-zshrc
```

**Work (1Password):**
```sh
op item create --category=login --title="my-secret" --vault=Personal credential='<value>'
# Reference as: op read op://Personal/my-secret/credential
```

**One-offs (not committing):** add to `~/.secrets.local` (gitignored, sourced automatically).

## Per-machine git identity (`~/.gitconfig-work`)

The tracked `dot-gitconfig` holds your personal identity. On the **work machine**, create `~/.gitconfig-work` (never committed) — git loads it automatically for any repo under `~/work/`:

```ini
[user]
    name = Lubosz Kosnik
    email = lubosz@<your-company>.com
    # Optional: pin a specific key instead of relying on the SSH agent
    # signingkey = ~/.ssh/id_ed25519.pub
```

Commit signing is on by default (`commit.gpgsign = true`, `gpg.format = ssh`). By default, git uses `ssh-add -L` to pick the signing key from your SSH agent — macOS loads keys from Keychain automatically, so this Just Works on both machines without any hardcoded paths.

If you ever need to pin a specific key (e.g. you have multiple SSH keys and want to be explicit):

```sh
# Check what keys are in your agent
ssh-add -L

# Pin one explicitly (writes to ~/.gitconfig, which is stowed from dot-gitconfig)
git config --global user.signingkey ~/.ssh/id_ed25519.pub
```

To tell GitHub about your signing key: **Settings → SSH and GPG keys → New SSH key → Key type: Signing Key**. Once added, your commits will show "Verified" on GitHub.

> **Note:** if you use 1Password SSH agent on the work machine, set `signingkey` to the public key shown in 1Password under the SSH key item, and make sure the 1Password SSH agent is enabled in 1Password settings.

---

## First-time setup checklist

### Both machines
- [ ] Run `./scripts/bootstrap.sh`
- [ ] Open VSCode → `Cmd+Shift+P` → `Settings Sync: Turn On` → sign in with GitHub
- [ ] Open nvim (`nvim`) — NvChad auto-installs plugins on first launch

### Work machine (M4 Apple Silicon)
- [ ] Add `export DOTFILES_PROFILE=work` to `~/.zshenv`
- [ ] Create `~/.gitconfig-work` (see [Per-machine git identity](#per-machine-git-identity-gitconfig-work) above)
- [ ] Add your work SSH signing key to GitHub: Settings → SSH and GPG keys → New SSH key → **Signing Key**
- [ ] Run `op signin`
- [ ] Run `granted sso login` + `granted sso populate` (see AWS SSO section above)

### Personal machine (Intel)
- [ ] Store API keys in Keychain (`security add-generic-password ...`)
- [ ] Add your personal SSH signing key to GitHub: Settings → SSH and GPG keys → New SSH key → **Signing Key** (paste output of `cat ~/.ssh/id_rsa.pub`)

## Updating

```sh
cd ~/dotfiles && git pull && brew bundle && stow .
```
