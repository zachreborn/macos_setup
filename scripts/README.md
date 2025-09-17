# Bootstrap Script Documentation

## Overview

The `bootstrap-macos.sh` script automates the complete setup of a macOS development environment based on the configuration in this repository.

## Features

### 🛡️ Safety & Reliability
- **Idempotent**: Safe to run multiple times without breaking existing setups
- **Dry-run mode**: Preview changes with `--dry-run` flag
- **Error handling**: Robust error checking with detailed logging
- **Backup**: Automatically backs up existing configurations before overwriting

### 🧠 Intelligence
- **Platform detection**: Automatically handles Apple Silicon vs Intel differences
- **Conditional installation**: Only installs missing components
- **Path detection**: Finds Homebrew installations in standard locations
- **Version checking**: Requires minimum macOS version (11+)

### 📦 Comprehensive Installation
- **Package Manager**: Homebrew with auto-updates configured
- **Shell Environment**: fish shell with Oh-My-Posh theming
- **Development Tools**: Complete CLI toolkit (git, aws, terraform, docker, etc.)
- **GUI Applications**: Essential productivity apps
- **System Configuration**: GPG, pyenv, shell integration

## Usage

```bash
# Preview what will be installed (recommended first run)
./scripts/bootstrap-macos.sh --dry-run

# Perform full installation
./scripts/bootstrap-macos.sh
```

## What Happens During Installation

### 1. Pre-flight Checks
- Verify macOS version compatibility
- Install Xcode Command Line Tools if missing
- Install Rosetta 2 on Apple Silicon if needed

### 2. Homebrew Setup
- Install Homebrew if not present
- Configure shell environment integration
- Add required taps for specialized packages
- Enable automatic updates and cleanup

### 3. Package Installation
- **CLI Formulae**: Development tools and utilities
- **GUI Casks**: Applications like Chrome, VS Code, Docker Desktop
- **Fonts**: Nerd Fonts for terminal icon support

### 4. Shell Configuration
- Set fish as default shell (added to `/etc/shells`)
- Copy repository fish configuration with backup
- Configure environment variables (Homebrew, pyenv, GPG)
- Set up Oh-My-Posh with custom theme

### 5. Application Configuration
- Configure GPG to use macOS keychain integration
- Install custom Warp terminal theme
- Set up development environment paths

### 6. Verification & Reporting
- Verify all installations completed successfully
- Report any issues or missing components
- Provide manual next steps for user accounts and preferences

## Manual Steps After Installation

The script will remind you of these required manual steps:

1. **Launch Docker Desktop** to complete privileged helper installation
2. **Sign in to applications**:
   - Dropbox
   - GitHub Desktop  
   - Amazon WorkSpaces
   - Steam
   - Discord
3. **Configure Warp theme** in Settings → Appearance → Themes
4. **Restart terminal** or log out/in for shell changes

## Optional Next Steps

- `gh auth login` - Authenticate GitHub CLI
- `aws configure` - Set up AWS credentials  
- `pyenv install 3.12 && pyenv global 3.12` - Install Python
- Sign in to GitHub in VS Code to sync settings/extensions

## Architecture & Design

### File Structure
```
scripts/
├── bootstrap-macos.sh    # Main installation script
└── README.md            # This documentation

.config/fish/            # Shell configuration
.poshthemes/            # Oh-My-Posh theme
.warp/themes/           # Warp terminal theme
```

### Helper Functions
- `ensure_tap()` - Idempotent Homebrew tap management
- `ensure_formula()` - Safe CLI tool installation
- `ensure_cask()` - Safe GUI application installation
- `require_sudo()` - Persistent sudo session management

### Logging System
- **Blue** `==>` - Information messages
- **Green** `OK:` - Success confirmations  
- **Yellow** `WARN:` - Warnings and manual steps
- **Red** `ERR:` - Error messages

## Troubleshooting

### Common Issues

**Script fails during Homebrew installation**
- Ensure you have admin rights and internet connectivity
- Try running the official Homebrew installer manually first

**Permission denied errors**
- The script will request sudo access when needed
- Ensure your user account has administrator privileges

**Fish shell not set as default**
- May require logout/login to take effect system-wide
- Verify with `echo $SHELL` in a new terminal

**Applications don't appear in Launchpad immediately**
- macOS may take a few minutes to index new applications
- Try opening Spotlight and searching for the app name

### Getting Help

1. Run with `--dry-run` first to see what would be installed
2. Check the script output for specific error messages
3. Ensure your macOS version is 11+ (Big Sur or later)
4. Verify you have a stable internet connection

## Customization

To modify what gets installed, edit the arrays in the script:
- `FORMULAE` - CLI tools and libraries
- `CASKS` - GUI applications  
- Tap definitions in the setup section

The script is designed to be easily customizable while maintaining safety and reliability.