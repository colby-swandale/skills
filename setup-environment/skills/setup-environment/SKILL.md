---
name: setup-environment
description: Use when setting up a new Mac, reproducing this development environment, or changing what's installed/configured on it — adding or removing a Homebrew package, editing a dotfile (fish, ghostty, nvim, git, mise), or bumping a language runtime.
---

# Setup macOS Development Environment

## Overview

Self-contained setup for Colby's macOS (Apple Silicon) dev environment — tools and configs are pinned to this directory; language runtimes float (see step 5). The source of truth is this file plus one directory:

- the **package list** in *Fresh-Machine Setup* step 3 — every CLI tool, font, and GUI app.
- `dotfiles/` — canonical copies of the `$HOME` config files (`.config/**` + `.default-gems`). Not symlinked: Claude copies them into place and keeps the bundle and the live files in sync.

**Core principle:** never install or configure by hand. Change an artifact in this skill, then re-run the relevant command. The machine is downstream of this directory.

## When to Use

- Setting up a brand-new Mac, or rebuilding after a wipe.
- Adding/removing a Homebrew package or cask.
- Editing any managed dotfile (fish, ghostty, nvim, git, gh, mise, btop).
- Changing language runtimes (node/ruby) or default gems.

## Fresh-Machine Setup

Run these once, in order, **in bash or zsh** (not fish — these use POSIX/bash syntax):

```sh
# 1. Xcode Command Line Tools (compilers, git). Finish the GUI prompt before continuing.
xcode-select --install

# 2. Homebrew. The keepalive refreshes sudo so the install doesn't stall for your password;
#    we kill it once Homebrew is in (otherwise it loops until you close the terminal).
sudo -v
( while true; do sudo -n true; sleep 60; kill -0 "$$" 2>/dev/null || exit; done ) 2>/dev/null & KEEPALIVE=$!
NONINTERACTIVE=1 /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
kill "$KEEPALIVE" 2>/dev/null
eval "$(/opt/homebrew/bin/brew shellenv)"

# 3. Packages — this list is the source of truth. Add/remove a name and re-run to sync.
#    No auto-prune: removing a name here does NOT uninstall it (do that by hand).
#    CLI: fish=shell  mise=node/ruby versions  gh=GitHub CLI + git creds  zoxide=smarter cd
#         ripgrep=rg  btop=monitor  mole, lazygit, neovim, jq, awscli
brew install fish mise btop awscli zoxide gh lazygit neovim ripgrep jq mole
#    Casks: ghostty=terminal (launches fish), 2 nerd fonts, plus the GUI apps
brew install --cask font-cascadia-code font-caskaydia-cove-nerd-font ghostty \
  keyboardcleantool notion slack tailscale-app claude

# 4. Copy the bundled dotfiles into place. When this skill runs, Claude Code sets
#    $CLAUDE_PLUGIN_ROOT to the plugin's install dir. (Running by hand? Point DOTS at this
#    repo's skills/setup-environment/dotfiles instead.) `ditto` merges into ~/.config without
#    the BSD-cp nested-dir footgun and leaves unrelated files untouched. Overwrites managed
#    files — on a populated machine, see "Keeping in Sync" first.
DOTS="${CLAUDE_PLUGIN_ROOT}/skills/setup-environment/dotfiles"
ditto "$DOTS/.config" "$HOME/.config"
cp "$DOTS/.default-gems" "$HOME/.default-gems"

# 5. Language runtimes: node lts + ruby latest (.config/mise/config.toml), ruby-lsp (.default-gems).
#    Note: "lts"/"latest" float — a setup months later may resolve to newer versions. Pin exact
#    versions in config.toml if you ever need byte-identical runtimes.
mise install

# 6. Claude Code.
curl -fsSL https://claude.ai/install.sh | bash

# 7. (optional) Register fish as a login shell — Ghostty launches fish directly, so this only
#    matters for other terminals.
echo "$(brew --prefix)/bin/fish" | sudo tee -a /etc/shells >/dev/null
chsh -s "$(brew --prefix)/bin/fish"
```

## Modify Workflow (the important part)

All edits happen in **this plugin's git repo** (the canonical source), then ship via `/plugin update`.

| Goal | Do this |
|------|---------|
| Add/remove a tool or app | Edit step 3's list in the repo `SKILL.md`, then `brew install <name>` (or `brew uninstall <name>`, `--cask` for apps). No auto-prune — dropping a name won't uninstall it |
| Change a dotfile | Edit the file in the repo's `dotfiles/...`, then re-run step 4 to copy it into `$HOME`. No symlink, so the repo and `$HOME` are separate copies — ask Claude and it keeps them in sync |
| Add a brand-new config file | Create it under the repo's `dotfiles/.config/...`, then re-run step 4's `ditto` to copy it into place |
| Change node/ruby version | Edit `dotfiles/.config/mise/config.toml` in the repo, then `mise install` |
| Add a default gem | Edit `dotfiles/.default-gems` in the repo, then reinstall ruby via mise |

After any change: commit + push the repo, then `/plugin update setup-environment` to redeploy.
For local iteration without publishing, run `claude --plugin-dir <repo>` so the skill loads from your working copy.

## Keeping in Sync

Files are **copied, not symlinked**, so three copies exist and can drift:

1. **the repo** — this plugin's git source. Canonical; edit here.
2. **the installed plugin** at `$CLAUDE_PLUGIN_ROOT` — a deployment of the repo, replaced on every `/plugin update`. Never edit it directly.
3. **live `~/.config`** — what your shell actually reads.

Normal flow: edit in the repo → commit/push → `/plugin update setup-environment` → re-run step 4 to copy into `~/.config`.

- **A live file changed outside the skill:** copy it back into the repo's `dotfiles/` and commit, so the repo stays canonical.
- **Before overwriting a populated machine:** step 4's `ditto` overwrites managed files without asking. Diff first and adopt anything live worth keeping back into the repo:

```sh
DOTS="${CLAUDE_PLUGIN_ROOT}/skills/setup-environment/dotfiles"
diff -ru "$DOTS/.config" "$HOME/.config" | less    # review drift in both directions
```

## What's Deliberately Excluded

- `gh/hosts.yml` — auth state; regenerate with `gh auth login`.
- `fish_variables` — fish runtime/universal-variable state, not config.
- `nvim/lazy-lock.json`, `nvim/.neoconf.json` — LazyVim autogenerates these.

## Common Mistakes

- **Editing the installed `$CLAUDE_PLUGIN_ROOT` copy directly** → wiped on the next `/plugin update`. Edit the repo, not the deployment.
- **Installing a package without adding it to step 3's list** → it won't reappear on a rebuild. Keep the list current.
- **Editing `~/.config/...` without mirroring it into the repo's `dotfiles/`** → the edit is lost on the next setup (step 4 overwrites from the bundle) and never committed. Copy it back into the repo.
- **Running step 4 on a populated machine blind** → `ditto` overwrites your live configs with the bundled copies. Diff and adopt first (*Keeping in Sync*).
- **Forgetting `mise install` after editing `config.toml`** → the runtime won't actually change.
