# skills

Colby's personal [Claude Code](https://docs.claude.com/en/docs/claude-code) plugin marketplace.
Each subdirectory is a self-contained plugin; the catalog lives in
[`.claude-plugin/marketplace.json`](.claude-plugin/marketplace.json).

## Use

```sh
# In Claude Code:
/plugin marketplace add colby-swandale/skills
/plugin install <plugin>@colby-skills
```

## Plugins

| Plugin | Description |
|--------|-------------|
| [`setup-environment`](setup-environment/) | Repeatable macOS (Apple Silicon) dev environment — Homebrew packages + `~/.config` dotfiles, applied without symlinks or external tooling. |

## Adding a plugin

1. Create `<plugin-name>/.claude-plugin/plugin.json` (manifest) and put skills under
   `<plugin-name>/skills/<skill-name>/SKILL.md`.
2. Add an entry to `.claude-plugin/marketplace.json` with `"source": "./<plugin-name>"`.
3. Commit and push — `/plugin marketplace update colby-skills` picks it up.
