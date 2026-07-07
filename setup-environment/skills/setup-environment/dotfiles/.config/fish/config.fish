eval "$(/opt/homebrew/bin/brew shellenv)"

set fish_greeting

fish_add_path -m ~/bin
fish_add_path -m ~/.local/bin
fish_add_path -m /opt/homebrew/opt/trash/bin

# Enable Claude Code LSP tool support
set -gx ENABLE_LSP_TOOL 1

set -gx EDITOR vim
set -gx VISUAL vim

# zoxide: smarter cd — `z <fuzzy name>` jumps to frecent dirs
zoxide init fish | source

# Abbreviations
abbr -a rm trash
abbr -a gs 'git status'
abbr -a gd 'git diff'
abbr -a gl 'git log --oneline'
abbr -a gp 'git push'
abbr -a gc 'git commit'
abbr -a ga 'git add'
abbr -a gco 'git checkout'
abbr -a gb 'git branch'
