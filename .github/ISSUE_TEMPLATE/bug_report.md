---
name: Bug Report
about: Create a report to help us improve
title: '[BUG] '
labels: bug
assignees: ''
---

# 🐛 Bug Report

## 📋 Describe the bug
A clear and concise description of what the bug is.

## 🔄 To Reproduce
Steps to reproduce the behavior:
1. Run command '...'
2. See error '...'

## ✅ Expected behavior
A clear and concise description of what you expected to happen.

## 📱 Screenshots/Output
If applicable, add screenshots or paste terminal output to help explain your problem.

```
Paste error output here
```

## 🖥️ Environment
- macOS Version: [e.g. 14.1]
- Architecture: [Apple Silicon M1/M2/M3 or Intel]
- Shell: [fish, zsh, bash]
- Script version: [commit hash or latest]

## 🧪 Additional context
- Did you run the script with `--dry-run` first?
- Are you running on a fresh macOS installation or existing setup?
- Any other context about the problem here.

## 🔍 Debugging information
Please run and paste the output of:
```bash
# System info
sw_vers
uname -a

# Homebrew status (if installed)
brew --version
brew doctor

# Script dry-run (if possible)
./scripts/bootstrap-macos.sh --dry-run
```