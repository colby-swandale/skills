# setup-environment

A Claude Code plugin that sets up Colby's macOS (Apple Silicon) development environment:
Homebrew packages plus `~/.config` dotfiles (fish, ghostty, nvim, git, gh, mise, btop), applied
without symlinks or external dotfile managers. This repo is both the plugin and its marketplace.

## Install

```sh
# In Claude Code:
/plugin marketplace add colby-swandale/setup-environment
/plugin install setup-environment@colby-skills
```

Then ask Claude to run the **setup-environment** skill.

## Fresh-Mac bootstrap order

On a brand-new Mac there's a chicken-and-egg (you need Claude Code to run the skill):

1. Install Claude Code: `curl -fsSL https://claude.ai/install.sh | bash`
2. Add the marketplace and install the plugin (commands above).
3. Open `claude` and ask it to run the **setup-environment** skill — it installs Homebrew +
   packages, copies the bundled dotfiles into `~/.config`, installs language runtimes via mise,
   and (optionally) sets fish as the login shell.

## Layout

```
.claude-plugin/
  plugin.json            # plugin manifest
  marketplace.json       # marketplace catalog (source: "./")
skills/
  setup-environment/
    SKILL.md             # the skill
    dotfiles/            # canonical ~/.config copies + .default-gems
```

## Editing the environment

`dotfiles/` in this repo is the source of truth. Change a config or the package list here,
commit, push, then `/plugin update setup-environment` and re-run the skill's step 4 to apply.
See `skills/setup-environment/SKILL.md` for the full workflow.
