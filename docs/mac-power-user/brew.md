# Homebrew Package Manager

## What is Homebrew?

[Homebrew](https://brew.sh) is the de facto package manager for macOS. It installs command-line tools, libraries, and GUI applications (via `brew install --cask`) that Apple does not ship with macOS, without requiring root access or manual PATH management.

## Top 5 Most Useful Packages

1. **`fzf`:** A general-purpose fuzzy finder for the terminal. Integrates with shell history (`Ctrl+R`), file selection, and any command that produces a list. Once installed, everything becomes searchable.

2. **`zoxide`:** A smarter `cd` that learns your most-visited directories. `z foo` jumps to the most frecent directory matching "fo:o" no full path needed. Replaces `cd` for navigation entirely once the database is warm.

3. **`ripgrep`:** A faster `grep -r` written in Rust. Respects `.gitignore` by default, handles binary files gracefully, and makes searching large codebases actually pleasant. Should be the default.

4. **`fd`:** What `find` should have been. Cleaner syntax, respects `.gitignore`, significantly faster, and sane defaults. `fd -e md` finds all markdown files recursively without any glob gymnastics.

5. **`git-delta`:** A syntax-highlighting pager for `git diff` and `git log` output. Makes diffs significantly more readable with side-by-side view, line numbers, and syntax highlighting. Hard to go back once you've used it.

## Honourable Mentions

- **`gh`:** GitHub's official CLI. Create PRs, check workflow runs, review issues, and clone repos without leaving the terminal.

- **`bat`:** `cat` with syntax highlighting, line numbers, and git change indicators. Pairs well with `fzf` for file previews.

- **`jq`:** JSON processor for the terminal. Indispensable when working with APIs or parsing GitHub Actions outputs.

- **`yq`:** Same as `jq` but for YAML. Relevant given how much YAML CI/CD configuration involves.

- **`tree`:** Directory tree visualizer. macOS does not ship with it despite being a standard Unix tool.

- **`ffmpeg`:** Audio/video processing Swiss Army knife. A dependency for many tools but also directly useful for quick conversions and processing.

- **`uv`:** An extremely fast Python package and project manager written in Rust. Replaces `pip`, `pip-tools`, `pipx`, `pyenv`, and `venv` in one tool.

- **`rclone`:** Rsync for cloud storage. Syncs files to S3, B2, Google Drive, and 70+ other providers.

- **`scrcpy`:** Screen copy. Mirrors and controls an Android device over USB or TCP/IP with near-zero latency. No app installation required on the device. Pronounced "screen copy" despite looking like a typo.

- **`swiftlint`:** Swift linter enforcing style and conventions. Essential for any Swift project.

- **`xcodegen`:** Generates Xcode project files from a YAML spec, keeping `.xcodeproj` out of version control and merge conflicts.

- **`gnupg`** + **`pinentry-mac`:** GPG key management with native macOS keychain integration for commit signing.

- **`smartmontools`:** Disk health monitoring via S.M.A.R.T. data right from the terminal.

- **`starship`:** Cross-shell prompt that shows git branch, language versions, exit codes, and more. Fast, highly configurable, looks great.

- **`maccy`:** Clipboard manager for macOS. Keeps clipboard history accessible via a menu bar icon.

- **`tmux`:** Terminal multiplexer. Multiple sessions, windows, and panes in one terminal. Essential for remote SSH sessions.

- **`dnslookup`:** DNS debugging tool. More feature-rich than `dig` for testing DNS resolution across different resolvers.

## Practical Task

|                                         **Screenshot**                                          |
| :---------------------------------------------------------------------------------------------: |
| ![Homebrew Package List](../../assets/onboarding/Screenshot%202026-05-29%20at%209.44.51 AM.png) |
|                       *`brew list` showing installed formulae and casks*                        |
