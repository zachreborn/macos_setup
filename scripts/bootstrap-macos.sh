#!/usr/bin/env bash
# macOS Bootstrap Script
# Automatically installs Homebrew and all applications/tools from your README.md
# This script is idempotent - safe to run multiple times
set -euo pipefail
IFS=$'\n\t'

# Colors for logging
log() { printf "\033[1;34m==>\033[0m %s\n" "$*"; }
ok() { printf "\033[1;32mOK:\033[0m %s\n" "$*"; }
warn() { printf "\033[1;33mWARN:\033[0m %s\n" "$*"; }
err() { printf "\033[1;31mERR:\033[0m %s\n" "$*" >&2; }
abort() { err "$*"; exit 1; }

# Error handling
trap 'err "Failed at line $LINENO"; exit 1' ERR

# Check for dry run mode
DRY_RUN=false
if [[ "${1:-}" == "--dry-run" ]]; then
  DRY_RUN=true
  log "Running in DRY RUN mode - no changes will be made"
fi

# System info
arch="$(uname -m)"
if [[ "$arch" == "arm64" ]]; then 
  HOMEBREW_PREFIX="/opt/homebrew"
else 
  HOMEBREW_PREFIX="/usr/local"
fi
HOMEBREW_BIN="$HOMEBREW_PREFIX/bin"

# Repository paths
REPO_ROOT="$(cd "$(dirname "${BASH_SOURCE[0]}")/.." && pwd -P)"
REPO_FISH_DIR="$REPO_ROOT/.config/fish"
REPO_OMP_THEME="$REPO_ROOT/.poshthemes/octo-theme.omp.json"
REPO_WARP_THEME="$REPO_ROOT/.warp/themes/hyper_material.yaml"

log "Starting macOS bootstrap from repository: $REPO_ROOT"

# Sudo session keeper for privileged operations
require_sudo() {
  if [[ "$DRY_RUN" == "true" ]]; then
    log "[DRY RUN] Would request sudo access"
    return
  fi
  
  if ! sudo -n true 2>/dev/null; then
    log "Requesting administrator password for privileged steps..."
    sudo -v
    # Keep sudo session alive
    while true; do sudo -n true; sleep 60; kill -0 "$$" || exit; done 2>/dev/null &
  fi
}

# Homebrew helper functions
ensure_tap() {
  local tap="$1"
  if [[ "$DRY_RUN" == "true" ]]; then
    log "[DRY RUN] Would ensure tap: $tap"
    return
  fi
  
  if ! brew tap | grep -qx "$tap"; then
    log "Tapping $tap"
    brew tap "$tap"
  else
    ok "Tap already added: $tap"
  fi
}

ensure_formula() {
  local formula="$1"
  if [[ "$DRY_RUN" == "true" ]]; then
    log "[DRY RUN] Would ensure formula: $formula"
    return
  fi
  
  if ! brew list --formula -1 2>/dev/null | grep -qx "$(basename "$formula")"; then
    log "Installing formula: $formula"
    brew install "$formula"
  else
    ok "Formula already installed: $formula"
  fi
}

ensure_cask() {
  local cask="$1"
  if [[ "$DRY_RUN" == "true" ]]; then
    log "[DRY RUN] Would ensure cask: $cask"
    return
  fi
  
  if ! brew list --cask -1 2>/dev/null | grep -qx "$cask"; then
    log "Installing cask: $cask"
    brew install --cask "$cask"
  else
    ok "Cask already installed: $cask"
  fi
}

# =============================================================================
# PRE-FLIGHT CHECKS
# =============================================================================

log "Running pre-flight checks..."

# Check macOS version (require at least macOS 11)
macos_major="$(sw_vers -productVersion | awk -F. '{print $1}')"
if [[ "${macos_major:-0}" -lt 11 ]]; then
  abort "macOS 11 or later is required. Current version: $(sw_vers -productVersion)"
fi
ok "macOS version: $(sw_vers -productVersion)"

# Check for Command Line Tools
if ! xcode-select -p >/dev/null 2>&1; then
  if [[ "$DRY_RUN" == "true" ]]; then
    warn "[DRY RUN] Xcode Command Line Tools not installed - would trigger installation"
  else
    log "Installing Xcode Command Line Tools..."
    xcode-select --install || true
    warn "Please complete the GUI installer for Xcode Command Line Tools, then re-run this script."
    abort "Xcode Command Line Tools installation required"
  fi
else
  ok "Xcode Command Line Tools installed"
fi

# Install Rosetta 2 on Apple Silicon if needed
if [[ "$arch" == "arm64" ]]; then
  if ! /usr/bin/pgrep oahd >/dev/null 2>&1; then
    if [[ "$DRY_RUN" == "true" ]]; then
      log "[DRY RUN] Would install Rosetta 2 for Apple Silicon compatibility"
    else
      log "Installing Rosetta 2 (required for some x86 apps)..."
      require_sudo
      softwareupdate --install-rosetta --agree-to-license || warn "Rosetta install may have been skipped by user."
    fi
  else
    ok "Rosetta 2 already installed"
  fi
fi

# =============================================================================
# HOMEBREW INSTALLATION & SETUP
# =============================================================================

log "Setting up Homebrew..."

# Install Homebrew if not present
if ! command -v brew >/dev/null 2>&1; then
  if [[ "$DRY_RUN" == "true" ]]; then
    log "[DRY RUN] Would install Homebrew"
  else
    log "Installing Homebrew..."
    NONINTERACTIVE=1 /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
  fi
fi

# Initialize Homebrew in current session
if [[ "$DRY_RUN" == "false" ]]; then
  if [[ -x "$HOMEBREW_BIN/brew" ]]; then
    eval "$("$HOMEBREW_BIN/brew" shellenv)"
  else
    # Fallback: brew may be installed in different prefix
    eval "$(/opt/homebrew/bin/brew shellenv 2>/dev/null || /usr/local/bin/brew shellenv 2>/dev/null || true)"
  fi
fi

# Persist Homebrew environment for zsh and bash
if [[ "$DRY_RUN" == "true" ]]; then
  log "[DRY RUN] Would persist Homebrew environment in shell profiles"
else
  touch ~/.zprofile ~/.bash_profile 2>/dev/null || true
  
  if ! grep -q 'brew shellenv' ~/.zprofile 2>/dev/null; then
    # shellcheck disable=SC2016
    echo 'eval "$($(/opt/homebrew/bin/brew shellenv 2>/dev/null || /usr/local/bin/brew shellenv 2>/dev/null))"' >> ~/.zprofile
  fi
  
  if ! grep -q 'brew shellenv' ~/.bash_profile 2>/dev/null; then
    # shellcheck disable=SC2016
    echo 'eval "$($(/opt/homebrew/bin/brew shellenv 2>/dev/null || /usr/local/bin/brew shellenv 2>/dev/null))"' >> ~/.bash_profile
  fi
  
  ok "Homebrew environment persisted in shell profiles"
fi

# Add required taps
log "Adding required Homebrew taps..."
ensure_tap "homebrew/cask-fonts"
ensure_tap "jandedobbeleer/oh-my-posh"
ensure_tap "homebrew/autoupdate"

# Configure Homebrew autoupdate (if not in dry-run mode)
if [[ "$DRY_RUN" == "true" ]]; then
  log "[DRY RUN] Would configure Homebrew autoupdate"
else
  if brew autoupdate status 2>/dev/null | grep -qi "Autoupdate is not" || ! brew autoupdate status >/dev/null 2>&1; then
    log "Enabling Homebrew autoupdate (daily upgrades, cleanup, notifications)..."
    brew autoupdate start --upgrade --cleanup --enable-notification 2>/dev/null || warn "Could not enable autoupdate"
  else
    ok "Homebrew autoupdate already configured"
  fi
fi

# Update and clean Homebrew
if [[ "$DRY_RUN" == "true" ]]; then
  log "[DRY RUN] Would update and clean Homebrew"
else
  log "Updating Homebrew..."
  brew update
  brew doctor || warn "brew doctor reported issues; review above"
  brew cleanup
fi

# =============================================================================
# INSTALL CLI TOOLS (FORMULAE)
# =============================================================================

log "Installing CLI tools..."

FORMULAE=(
  "fish"
  "oh-my-posh"
  "gh"
  "awscli"
  "terraform"
  "terraform-docs"
  "pyenv"
  "pipenv"
  "ykman"
  "gnupg"           # provides gpg
  "pinentry-mac"
  "glances"
  "docker"
  "fd"
  "ripgrep"
)

for formula in "${FORMULAE[@]}"; do
  ensure_formula "$formula"
done

# =============================================================================
# INSTALL GUI APPLICATIONS (CASKS)
# =============================================================================

log "Installing GUI applications..."

CASKS=(
  "google-chrome"
  "warp"
  "visual-studio-code"
  "github"
  "amazon-workspaces"
  "discord"
  "dropbox"
  "steam"
  "obsidian"
  "docker-desktop"
  "soundsource"
)

for cask in "${CASKS[@]}"; do
  ensure_cask "$cask"
done

# =============================================================================
# INSTALL FONTS
# =============================================================================

log "Installing fonts..."
ensure_cask "font-hack-nerd-font"

# =============================================================================
# CONFIGURE FISH SHELL
# =============================================================================

log "Configuring fish shell..."

if [[ "$DRY_RUN" == "true" ]]; then
  log "[DRY RUN] Would configure fish as default shell"
else
  FISH_PATH="$(brew --prefix)/bin/fish"
  if [[ ! -x "$FISH_PATH" ]]; then
    abort "fish not found at $FISH_PATH"
  fi
  
  # Add fish to allowed shells
  require_sudo
  if ! grep -qx "$FISH_PATH" /etc/shells; then
    log "Adding $FISH_PATH to /etc/shells"
    echo "$FISH_PATH" | sudo tee -a /etc/shells >/dev/null
  else
    ok "Fish already in /etc/shells"
  fi
  
  # Set fish as default shell
  if [[ "$SHELL" != "$FISH_PATH" ]]; then
    log "Setting default shell to fish"
    chsh -s "$FISH_PATH"
  else
    ok "Fish is already the default shell"
  fi
fi

# Create fish configuration directories
if [[ "$DRY_RUN" == "true" ]]; then
  log "[DRY RUN] Would create fish config directories"
else
  mkdir -p ~/.config/fish/{conf.d,functions} ~/.poshthemes
  ok "Fish config directories created"
fi

# Copy fish configuration from repository
if [[ "$DRY_RUN" == "true" ]]; then
  log "[DRY RUN] Would sync fish config from repository"
elif [[ -f "$REPO_FISH_DIR/config.fish" ]]; then
  log "Syncing fish config from repository..."
  
  # Backup existing config if it exists
  if [[ -d ~/.config/fish ]] && [[ "$(ls -A ~/.config/fish 2>/dev/null)" ]]; then
    backup_dir="$HOME/.config/fish/.backup_$(date +%Y%m%d_%H%M%S)"
    mkdir -p "$backup_dir"
    cp -r ~/.config/fish/* "$backup_dir/" 2>/dev/null || true
    log "Backed up existing fish config to $backup_dir"
  fi
  
  # Copy new config
  cp -r "$REPO_FISH_DIR"/* ~/.config/fish/
  ok "Fish config synced from repository"
else
  warn "Fish config not found in repository at $REPO_FISH_DIR"
fi

# Configure additional environment variables for fish
if [[ "$DRY_RUN" == "true" ]]; then
  log "[DRY RUN] Would configure fish environment variables"
else
  FISH_ENV="$HOME/.config/fish/conf.d/10-env.fish"
  
  # Ensure Homebrew in PATH for fish sessions
  if ! grep -q "brew shellenv" "$FISH_ENV" 2>/dev/null; then
    cat >> "$FISH_ENV" <<'EOF'
# Homebrew environment
if status --is-interactive
    eval (/opt/homebrew/bin/brew shellenv 2>/dev/null; or /usr/local/bin/brew shellenv 2>/dev/null)
end
EOF
  fi
  
  # GPG_TTY for gpg
  if ! grep -q "GPG_TTY" "$FISH_ENV" 2>/dev/null; then
    echo 'set -gx GPG_TTY (tty)' >> "$FISH_ENV"
  fi
  
  ok "Fish environment variables configured"
fi

# =============================================================================
# CONFIGURE OH-MY-POSH
# =============================================================================

log "Configuring Oh-My-Posh..."

if [[ "$DRY_RUN" == "true" ]]; then
  log "[DRY RUN] Would configure Oh-My-Posh theme"
elif [[ -f "$REPO_OMP_THEME" ]]; then
  TARGET_OMP_THEME="$HOME/.poshthemes/octo-theme.omp.json"
  cp -f "$REPO_OMP_THEME" "$TARGET_OMP_THEME"
  ok "Oh-My-Posh theme installed to $TARGET_OMP_THEME"
  
  # The theme should already be configured in the fish config.fish from the repo
  ok "Oh-My-Posh configured (theme reference in fish config)"
else
  warn "Oh-My-Posh theme not found at $REPO_OMP_THEME"
fi

# =============================================================================
# CONFIGURE GPG
# =============================================================================

log "Configuring GPG..."

if [[ "$DRY_RUN" == "true" ]]; then
  log "[DRY RUN] Would configure GPG with pinentry-mac"
else
  mkdir -p ~/.gnupg
  chmod 700 ~/.gnupg
  
  PINENTRY_BIN="$(brew --prefix)/bin/pinentry-mac"
  GPG_AGENT_CONF="$HOME/.gnupg/gpg-agent.conf"
  
  if ! grep -q "pinentry-program" "$GPG_AGENT_CONF" 2>/dev/null; then
    echo "pinentry-program $PINENTRY_BIN" >> "$GPG_AGENT_CONF"
    ok "Configured pinentry program in gpg-agent.conf"
  else
    ok "GPG pinentry already configured"
  fi
  
  # Restart GPG agent to pick up new config
  gpgconf --kill gpg-agent 2>/dev/null || true
fi

# =============================================================================
# CONFIGURE WARP THEME
# =============================================================================

log "Configuring Warp theme..."

if [[ "$DRY_RUN" == "true" ]]; then
  log "[DRY RUN] Would install Warp theme"
else
  WARP_DIR="$HOME/.warp/themes"
  mkdir -p "$WARP_DIR"
  
  if [[ -f "$REPO_WARP_THEME" ]]; then
    cp -f "$REPO_WARP_THEME" "$WARP_DIR/"
    ok "Warp theme copied to $WARP_DIR"
  else
    warn "Warp theme not found at $REPO_WARP_THEME"
  fi
fi

# =============================================================================
# VERIFICATION
# =============================================================================

if [[ "$DRY_RUN" == "true" ]]; then
  log "[DRY RUN] Would verify installations"
else
  log "Verifying installations..."
  
  for cmd in brew fish gh aws terraform terraform-docs pyenv pipenv ykman gpg glances docker fd ripgrep oh-my-posh; do
    if command -v "$cmd" >/dev/null 2>&1; then
      version_info="$("$cmd" --version 2>/dev/null | head -n1 || echo "installed")"
      printf "%-16s %s\n" "$cmd" "$version_info"
    else
      warn "$cmd not found in PATH"
    fi
  done
fi

# =============================================================================
# FINAL MESSAGES
# =============================================================================

if [[ "$DRY_RUN" == "true" ]]; then
  log "DRY RUN completed - no changes were made"
  log "Run without --dry-run to perform the actual installation"
else
  log "Bootstrap completed successfully! 🎉"
  echo
  warn "MANUAL STEPS REQUIRED:"
  warn "1. Launch Docker Desktop to complete setup (will request privileged helper)"
  warn "2. Sign in to your accounts:"
  warn "   - Dropbox"
  warn "   - GitHub Desktop"
  warn "   - Amazon WorkSpaces"
  warn "   - Steam"
  warn "   - Discord"
  warn "3. In Warp: Settings → Appearance → Themes → select 'hyper_material'"
  warn "4. Restart your terminal or log out/in for shell changes to take effect"
  echo
  ok "OPTIONAL NEXT STEPS:"
  ok "• Run: gh auth login"
  ok "• Run: aws configure"
  ok "• Install Python: pyenv install 3.12 && pyenv global 3.12"
  ok "• Configure VS Code: Sign in to GitHub to sync settings/extensions"
  echo
  ok "Your macOS development environment is ready!"
fi