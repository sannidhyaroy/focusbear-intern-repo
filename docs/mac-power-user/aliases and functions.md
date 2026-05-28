# Custom Aliases and Functions

## `.zshrc` Snippet

```bash
# Navigation
alias ..='cd ..'
alias ...='cd ../..'
alias ll='ls -lA'
alias la='ls -A'

# Git
alias gs='git status'
alias gd='git diff'
alias gl='git log --oneline --graph --decorate --all'
alias gp='git push'
alias gap='git add -p'

# Docker
alias dps='docker ps --format "table {{.Names}}\t{{.Status}}\t{{.Ports}}"'
alias dca='docker compose up -d'

# Functions
mkcd() {
    mkdir -p "$1" && cd "$1"
}

gacp() {
    git add -p && git commit -m "$1" && git push
}
```

**Aliases explained:**

- `..` / `...`: navigate up one or two levels without typing `cd`
- `ll`: long list with hidden files, the sensible default for `ls`
- `la`: show hidden files without long format, quick overview
- `gs`: `git status` is typed constantly, 8 keystrokes → 2
- `gd`: quick diff check before staging
- `gl`: full visual branch graph in one command
- `gp`: push current branch
- `gap`: interactive partial staging, used constantly

**Functions explained:**

- `mkcd`: create a directory and immediately enter it. The most common
  two-command sequence collapsed into one.
- `gacp`: add interactively, commit with a message, and push in one
  command. Useful for quick documentation commits.
